/**
* Module that will hold all the platform APIs
*/
module resource_account::trading_platform {
	use aptos_framework::account;
	use aptos_framework::aptos_coin::AptosCoin;
	use aptos_framework::timestamp;

	use aptos_std::math64::min;

	use resource_account::constants;
	use resource_account::dummy_coin::DummyCoin;
	use resource_account::order::{Self, OrderHeap};	
	use resource_account::position;
	
	use std::error;
	use std::signer;
	use std::vector;

	#[test_only]
	use resource_account::dummy_coin;

	const ENOT_ENOUGH_FUNDS: u64 = 0;

	const ONE_DAY_MS: u64 = 8640000000000;
	const MAX_PRICE: u64 = 0xffffffffffffffff;

	const BUYER_RATIO: u64 = 1;
	const SELLER_RATIO: u64 = 2;

	struct ContractStorage has key {
		signer_cap: account::SignerCapability,
		sellOrders : OrderHeap,					//	Only active sell orders
		buyOrders : OrderHeap,					//	Only active buy orders
		global_expiration_time: u64,
		lastPrice: u64,
	}

	struct UserResource has key, drop {	
		activeOrders: vector<u64>
	}

	entry fun init_module(admin: &signer) {
		let signer_cap = aptos_framework::resource_account::retrieve_resource_account_cap(admin, @publisher_addr);
		let sig = &account::create_signer_with_capability(&signer_cap);

		aptos_framework::coin::register<AptosCoin>(sig);
		aptos_framework::coin::register<DummyCoin>(sig);

		move_to(admin, ContractStorage {
			signer_cap: signer_cap,
			sellOrders: order::MinHeap(),
			buyOrders: order::MaxHeap(),
			global_expiration_time: timestamp::now_microseconds() + ONE_DAY_MS,
			lastPrice: 0u64,
		});
	}

	/**
	*	Register a new user by
	*	creating a resource under
	*	his address
	*/
	public entry fun register(sender: &signer) {
		let user_resource = UserResource {
			activeOrders: vector::empty<u64>()
		};

		move_to(sender, user_resource);
	}

	/**
	*	Add a new sell request
	*	for the seller
	*/
	public entry fun limit_short(seller: &signer, price: u64, units: u64, flexible: bool) acquires ContractStorage, UserResource {
		check_registration(seller);
		let contractStore = borrow_global_mut<ContractStorage>(@resource_account);

		let now = timestamp::now_microseconds();
		if (now >= contractStore.global_expiration_time) {
			contractStore.global_expiration_time = ((now - contractStore.global_expiration_time)/ONE_DAY_MS)*ONE_DAY_MS + ONE_DAY_MS ;
		};

		let userStore = borrow_global_mut<UserResource>(signer::address_of(seller));
	
		//	Get a new order
		let id = order::newOrder(
			price,
			units,
			signer::address_of(seller),
			constants::Sell(),
			flexible,
			constants::Active(),
		);

		//	Add the order's ID to the user's list
		vector::push_back(&mut userStore.activeOrders, id);

		//	Fill margin
		let initial_margin = SELLER_RATIO * price * units ;
		let success = try_and_acquire(seller, initial_margin);

		if (!success) {
			order::set_state(id, constants::Failed());
			return
		};
	
		//	Fullfill the order if possible
		let counter_heap = &mut contractStore.buyOrders;
		let (matchedUnits, matches) = order::heap_match(counter_heap, id);
		if (matchedUnits >= units) {
			order::set_state(id, constants::Fulfilled());

			vector::for_each(matches, |matched_order| {
				let strike_units = min(units, order::units(matched_order));
				execute_trade(
					matched_order,
					id,
					order::price(matched_order),
					strike_units,
					contractStore
				);
				units = units - strike_units;
				if (strike_units == order::units(matched_order))
					order::set_state(matched_order, constants::Fulfilled())
				else
					order::set_state(matched_order, constants::Partial())
				;
			});
		} else if (flexible && matchedUnits != 0) {
			vector::for_each(matches, |matched_order| {
				let strike_units = min(units, order::units(matched_order));
				execute_trade(
					matched_order,
					id,
					order::price(matched_order),
					strike_units,
					contractStore
				);
				units = units - strike_units;
				if (strike_units == order::units(matched_order))
					order::set_state(matched_order, constants::Fulfilled())
				else
					order::set_state(matched_order, constants::Partial())
				;
			});
		
			order::set_state(id, constants::Partial());
			order::set_units(id, units);
			order::heap_insert(&mut contractStore.sellOrders, id);
		} else {
			vector::for_each(matches, |match_id| {
				order::heap_insert(counter_heap, match_id);
			});
			order::heap_insert(&mut contractStore.sellOrders, id);
		};
	}

	/**
	*	Add a new buy request
	*	for the buyer
	*/
	public entry fun limit_long(buyer: &signer, price: u64, units: u64, flexible: bool) acquires ContractStorage, UserResource {
		check_registration(buyer);
		let contractStore = borrow_global_mut<ContractStorage>(@resource_account);

		let now = timestamp::now_microseconds();
		if (now >= contractStore.global_expiration_time) {
			contractStore.global_expiration_time = ((now - contractStore.global_expiration_time)/ONE_DAY_MS)*ONE_DAY_MS + ONE_DAY_MS ;
		};

		let userStore = borrow_global_mut<UserResource>(signer::address_of(buyer));
	
		//	Get a new order
		let id = order::newOrder(
			price,
			units,
			signer::address_of(buyer),
			constants::Sell(),
			flexible,
			constants::Active(),
		);

		//	Add the order's ID to the user's list
		vector::push_back(&mut userStore.activeOrders, id);

		//	Fill margin
		let initial_margin = BUYER_RATIO * price * units ;
		let success = try_and_acquire(buyer, initial_margin);

		if (!success) {
			order::set_state(id, constants::Failed());
			return
		};
	
		//	Fullfill the order if possible
		let counter_heap = &mut contractStore.sellOrders;
		let (matchedUnits, matches) = order::heap_match(counter_heap, id);
		if (matchedUnits >= units) {
			order::set_state(id, constants::Fulfilled());

			vector::for_each(matches, |matched_order| {
				let strike_units = min(units, order::units(matched_order));
				execute_trade(
					id,
					matched_order,
					order::price(matched_order),
					strike_units,
					contractStore
				);
				units = units - strike_units;
				if (strike_units == order::units(matched_order))
					order::set_state(matched_order, constants::Fulfilled())
				else
					order::set_state(matched_order, constants::Partial())
				;
			});
		} else if (flexible && matchedUnits != 0) {
			vector::for_each(matches, |matched_order| {
				let strike_units = min(units, order::units(matched_order));
				execute_trade(
					id,
					matched_order,
					order::price(matched_order),
					strike_units,
					contractStore
				);
				units = units - strike_units;
				if (strike_units == order::units(matched_order))
					order::set_state(matched_order, constants::Fulfilled())
				else
					order::set_state(matched_order, constants::Partial())
				;
			});
		
			order::set_state(id, constants::Partial());
			order::set_units(id, units);
			order::heap_insert(&mut contractStore.buyOrders, id);
		} else {
			vector::for_each(matches, |match_id| {
				order::heap_insert(counter_heap, match_id);
			});
			order::heap_insert(&mut contractStore.buyOrders, id);
		};
	}

	public entry fun market_long(buyer: &signer, amount: u64) acquires ContractStorage, UserResource {
		let storage = borrow_global_mut<ContractStorage>(@resource_account);

		assert!(fetch_balance(signer::address_of(buyer)) >= amount, error::resource_exhausted(ENOT_ENOUGH_FUNDS));
		
		if (order::heap_is_empty(&storage.sellOrders)) return;

		let top = order::heap_head(&mut storage.sellOrders);
		let best_price = order::price(top);
		let dummy_order = create_new_order_for(
			signer::address_of(buyer),
			MAX_PRICE,
			(amount / best_price),
			constants::Buy(),
			true,
			constants::Active(),
		);

		let (_, matched) = order::heap_match(&mut storage.sellOrders, dummy_order);
		
		vector::for_each(matched, |matched_order| {
			let strike_price = order::price(matched_order);
			let strike_units = min(maximum_buy_units(amount, strike_price), order::units(matched_order));
			let exit = false;

			if (!order::is_flexible(matched_order) && order::units(matched_order) != strike_units) {
				put_back(&mut storage.sellOrders, matched_order);
				exit = true;
			};

			if (strike_units == 0)
				exit = true
			;

			let margin = if (!exit) {
				let margin = calculate_buyer_margin(strike_price, strike_units);
				try_and_acquire(buyer, margin);
				margin
			} else 0u64;

			if (!exit) {
				execute_trade(
					dummy_order,
					matched_order,
					strike_price,
					strike_units,
					storage
				);
			};

			if (!exit) {
				if (strike_units == order::units(matched_order)) {
					order::set_state(matched_order, constants::Fulfilled());
				} else {
					order::set_units(matched_order, order::units(matched_order) - strike_units);
					order::set_state(matched_order, constants::Partial());
					put_back(&mut storage.sellOrders, matched_order);
				};
			};

			if (!exit) {
				amount = amount - margin;
			}
		});
	}

	public entry fun market_long_units(buyer: &signer, num_units: u64) acquires ContractStorage, UserResource {
		let storage = borrow_global_mut<ContractStorage>(@resource_account);

		let dummy_order = create_new_order_for(
			signer::address_of(buyer),
			MAX_PRICE,
			num_units,
			constants::Buy(),
			true,
			constants::Active(),
		);

		let (matched_units, matched) = order::heap_match(&mut storage.sellOrders, dummy_order);

		// Try and buy as many units as I can
		let left = num_units;		
		vector::for_each(matched, |matched_order| {
			let strike_units = min(order::units(matched_order), left);
			let strike_price = order::price(matched_order);
			let exit = false;
	
			let margin = calculate_buyer_margin(strike_price, strike_units);
			let success = try_and_acquire(buyer, margin);

			if (! success) {
				if (order::is_flexible(matched_order)) {
					strike_units = maximum_buy_units(fetch_balance(signer::address_of(buyer)), strike_price);
				} else {
					put_back(&mut storage.sellOrders, matched_order);
					exit = true;
				};
			};
			
			if (!exit && strike_units == 0) {
				put_back(&mut storage.sellOrders, matched_order);
				exit = true;
			};

			if (!exit) {
				execute_trade(
					dummy_order,
					matched_order,
					strike_price,
					strike_units,
					storage,
				);
			};
			
			if (!exit) {
				if (strike_units == order::units(matched_order)) {
					order::set_state(matched_order, constants::Fulfilled());
				} else {
					order::set_state(matched_order, constants::Partial());
					order::set_units(matched_order, order::units(matched_order) - strike_price);
					put_back(&mut storage.sellOrders, matched_order);
				};
			};

			if (!exit) {
				left = left - strike_units;
			}
		});

		order::set_units(dummy_order, num_units - left);
	}

	public entry fun market_short(seller: &signer, amount: u64) acquires ContractStorage, UserResource {
		let storage = borrow_global_mut<ContractStorage>(@resource_account);

		assert!(fetch_balance(signer::address_of(seller)) >= amount, error::resource_exhausted(ENOT_ENOUGH_FUNDS));
		
		if (order::heap_is_empty(&storage.buyOrders)) return;

		let top = order::heap_head(&mut storage.buyOrders);
		let best_price = order::price(top);
		let dummy_order = create_new_order_for(
			signer::address_of(seller),
			0,
			(amount / best_price),
			constants::Sell(),
			true,
			constants::Active(),
		);

		let (_, matched) = order::heap_match(&mut storage.buyOrders, dummy_order);
		
		vector::for_each(matched, |matched_order| {
			let strike_price = order::price(matched_order);
			let strike_units = min(maximum_sell_units(amount, strike_price), order::units(matched_order));
			let exit = false;

			if (!order::is_flexible(matched_order) && order::units(matched_order) != strike_units) {
				put_back(&mut storage.buyOrders, matched_order);
				exit = true;
			};

			if (strike_units == 0)
				exit = true
			;

			let margin = if (!exit) {
				let margin = calculate_seller_margin(strike_price, strike_units);
				try_and_acquire(seller, margin);
				margin
			} else 0u64 ;

			if (!exit) {
				execute_trade(
					dummy_order,
					matched_order,
					strike_price,
					strike_units,
					storage
				);
			};

			if (!exit) {
				if (strike_units == order::units(matched_order)) {
					order::set_state(matched_order, constants::Fulfilled());
				} else {
					order::set_units(matched_order, order::units(matched_order) - strike_units);
					order::set_state(matched_order, constants::Partial());
					put_back(&mut storage.buyOrders, matched_order);
				};
			};

			if (!exit) {
				amount = amount - margin;
			}
		});
	}

	public entry fun market_short_units(seller: &signer, num_units: u64) acquires ContractStorage, UserResource {
		assert!(num_units != 0, error::invalid_argument(1));
		let storage = borrow_global_mut<ContractStorage>(@resource_account);

		let dummy_order = create_new_order_for(
			signer::address_of(seller),
			0,
			num_units,
			constants::Sell(),
			true,
			constants::Active(),
		);

		let (matched_units, matched) = order::heap_match(&mut storage.buyOrders, dummy_order);

		// Try and buy as many units as I can
		let left = num_units;
		vector::for_each(matched, |matched_order| {
			let strike_units = min(order::units(matched_order), left);
			let strike_price = order::price(matched_order);
			let exit = false;
	
			let margin = calculate_seller_margin(strike_price, strike_units);
			let success = try_and_acquire(seller, margin);

			if (! success) {
				if (order::is_flexible(matched_order)) {
					strike_units = maximum_sell_units(fetch_balance(signer::address_of(seller)), strike_price);
				} else {
					put_back(&mut storage.buyOrders, matched_order) ;
					exit = true;
				};
			};
			
			if (!exit && strike_units == 0) {
				put_back(&mut storage.buyOrders, matched_order);
				exit = true;
			};

			if (!exit) {
				execute_trade(
					dummy_order,
					matched_order,
					strike_price,
					strike_units,
					storage,
				);
			};

			if (!exit) {
				if (strike_units == order::units(matched_order)) {
					order::set_state(matched_order, constants::Fulfilled());
				} else {
					order::set_state(matched_order, constants::Partial());
					order::set_units(matched_order, order::units(matched_order) - strike_units);
					put_back(&mut storage.buyOrders, matched_order);
				};
			};

			if (!exit) {
				left = left - strike_units;
			};
		});

		order::set_units(dummy_order, num_units - left);
	}

	
	/**
	*	Cancel a previuously made
	*	request by the user
	*/
	public entry fun cancel_request(user: &signer, order_id: u64) acquires ContractStorage, UserResource {
		check_registration(user);
		//	Grab all global stores
		let storage = borrow_global_mut<ContractStorage>(@resource_account);
		let userStore = borrow_global_mut<UserResource>(signer::address_of(user));

		//	Grab and remove the order_id from user's activeOrders list
		let (_, idx) = vector::index_of(&userStore.activeOrders, &order_id);
		vector::swap_remove(&mut userStore.activeOrders, idx);

		//	Change Order's state to cancelled
		order::set_state(order_id, constants::Cancelled());

		//	Return the token back to user
		let ratio = if (order::type(order_id) == constants::Buy())
			BUYER_RATIO
		else
			SELLER_RATIO
		;

		transfer_to(signer::address_of(user), ratio * order::price(order_id) * order::units(order_id), storage);
	}

	public entry fun close_position(user: &signer, position_id: u64) acquires ContractStorage, UserResource {
		let storage = borrow_global_mut<ContractStorage>(@resource_account);
		let strike_price = position::strike_price(position_id);
		let strike_units = position::strike_units(position_id);

		let backup = move_from<UserResource>(signer::address_of(user));
		register(user);
		if (position::is_long(position_id)) {
			let acquired_margin = calculate_buyer_margin(strike_price, strike_units);
			transfer_to(signer::address_of(user), acquired_margin, storage);
			market_long_units(user, position::strike_units(position_id));
		} else {
			let acquired_margin = calculate_seller_margin(strike_price, strike_units);
			transfer_to(signer::address_of(user), acquired_margin, storage);
			market_short_units(user, position::strike_units(position_id));
		};
		destroy_user_resource(signer::address_of(user));
		move_to(user, backup);
	}

	inline fun destroy_user_resource(user: address) {
		let UserResource { activeOrders: x } = move_from<UserResource>(user);
	}

	inline fun check_registration(user: &signer) {
		assert!(exists<UserResource>(signer::address_of(user)), error::permission_denied(0));
	}

	inline fun fetch_balance(addr: address): u64 {
		aptos_framework::coin::balance<AptosCoin>(addr)
	}

	inline fun add_to_orders(user: address, order: u64) acquires UserResource {
		vector::push_back(&mut borrow_global_mut<UserResource>(user).activeOrders, order);
	}

	inline fun create_new_order_for(
		user: address,
		price: u64,
		units: u64,
		type: u8,
		flexible: bool,
		state: u8
	): u64 acquires UserResource {
		let order = order::newOrder(
			price,
			units,
			user,
			type,
			flexible,
			state,
		);
		add_to_orders(user, order);
		order
	}

	inline fun calculate_buyer_margin(strike_price: u64, strike_units: u64): u64 {
		BUYER_RATIO * strike_price * strike_units
	}

	inline fun calculate_seller_margin(strike_price: u64, strike_units: u64): u64 {
		SELLER_RATIO * strike_price * strike_units
	}

	inline fun maximum_buy_units(amount: u64, strike_price: u64): u64 {
		amount / (BUYER_RATIO * strike_price)
	}

	inline fun maximum_sell_units(amount: u64, strike_price: u64): u64 {
		amount / (SELLER_RATIO * strike_price)
	}

	inline fun put_back(heap: &mut OrderHeap, order: u64) {
		order::heap_insert(heap, order);
	}

	fun transfer_to(to: address, amount: u64, storage: &ContractStorage) {
		let resource_signer = &account::create_signer_with_capability(&storage.signer_cap);
		aptos_framework::coin::transfer<AptosCoin>(resource_signer, to, amount);
	}

	fun try_and_acquire(from: &signer, amount: u64): bool {
		let balance = fetch_balance(signer::address_of(from));

		if (balance < amount) {
			return false
		};

		aptos_framework::coin::transfer<AptosCoin>(from, @resource_account, amount);
		return true
	}

	fun execute_trade(buy_order: u64, sell_order: u64, price: u64, units: u64, storage: &ContractStorage) {
		//	Create Positions
		let long_pos = create_position_for(
			buy_order,
			constants::Long(),
			price,
			units,
			timestamp::now_microseconds() + 10000,
		);
		let short_pos = create_position_for(
			sell_order,
			constants::Short(),
			price,
			units,
			timestamp::now_microseconds() + 10000,
		);
		
		let seller_leftover = SELLER_RATIO * (order::price(sell_order) - price) * units;
		let buyer_leftover = BUYER_RATIO * (price - order::price(buy_order)) * units ;

		if (!is_market_order(sell_order)) {
			transfer_to(order::from(sell_order), seller_leftover, storage);
		};
		if (!is_market_order(buy_order)) {
			transfer_to(order::from(buy_order), buyer_leftover, storage);
		};
	}

	inline fun is_market_order(order: u64): bool {
		order::price(order) == MAX_PRICE || order::price(order) == 0
	}

	inline fun create_position_for(order: u64, type: u8, strike_price: u64, strike_units: u64, expiration_time: u64): u64 {
		let pos = position::open_position(order, type, strike_price, strike_units, expiration_time);
		order::add_position(order, pos);
		pos
	}

	#[test_only]
	fun initialize_module(admin: &signer) {
		let publisher_sig = &create_user_with_address(@publisher_addr);
		aptos_framework::resource_account::create_resource_account(publisher_sig, vector::empty(), vector::empty());
		init_module(admin);
	}

	#[test_only]
	public fun make_limit_short(user: &signer, price: u64, units: u64, flexible: bool) acquires ContractStorage, UserResource {

		let user_addr = signer::address_of(user);

		let before_len = vector::length(&borrow_global<UserResource>(user_addr).activeOrders);
		let before_bal = aptos_framework::coin::balance<DummyCoin>(user_addr);

		limit_short(user, price, units, flexible);
		
		let after_len = vector::length(&borrow_global<UserResource>(signer::address_of(user)).activeOrders);
		assert!(before_len + 1 == after_len, 0u64);

		let after_bal = aptos_framework::coin::balance<DummyCoin>(user_addr);
		assert!(before_bal - units == after_bal, 1u64);
	}

	#[test_only]
	public fun limit_short_cancel(user: &signer, id: u64) acquires ContractStorage, UserResource {
		let user_addr = signer::address_of(user);

		let before_len = vector::length(&borrow_global<UserResource>(user_addr).activeOrders);
		let before_bal = aptos_framework::coin::balance<DummyCoin>(user_addr);
		
		cancel_request(user, id);

		let after_len = vector::length(&borrow_global<UserResource>(signer::address_of(user)).activeOrders);
		assert!(before_len - 1 == after_len, 0u64);

		let after_bal = aptos_framework::coin::balance<DummyCoin>(user_addr);
		assert!(before_bal + order::units(id) == after_bal, 1u64);
	}

	#[test_only]
	public fun limit_long_cancel(user: &signer, id: u64) acquires ContractStorage, UserResource {
		let user_addr = signer::address_of(user);

		let before_len = vector::length(&borrow_global<UserResource>(user_addr).activeOrders);
		let before_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);
		
		cancel_request(user, id);

		let after_len = vector::length(&borrow_global<UserResource>(signer::address_of(user)).activeOrders);
		assert!(before_len - 1 == after_len, 0u64);

		let after_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);
		assert!(before_bal + order::price(id)*order::units(id) == after_bal, 1u64);
	}

	#[test_only]
	public fun make_limit_long(user: &signer, price: u64, units: u64, flexible: bool) acquires ContractStorage, UserResource {

		let user_addr = signer::address_of(user);

		let before_len = vector::length(&borrow_global<UserResource>(user_addr).activeOrders);
		let before_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);

		limit_long(user, price, units, flexible);
		
		let after_len = vector::length(&borrow_global<UserResource>(signer::address_of(user)).activeOrders);
		assert!(before_len + 1 == after_len, 0u64);

		let after_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);
		assert!(before_bal <= units*price + after_bal, 1u64);
	}
	
	#[test_only]
	public fun initialize_aptos_coin(): aptos_framework::coin::MintCapability<AptosCoin> {
		let framework = &aptos_framework::account::create_signer_for_test(@aptos_framework);
		let (burn, mint) = aptos_framework::aptos_coin::initialize_for_test(framework);
		aptos_framework::coin::destroy_burn_cap(burn);
		mint
	}

	#[test_only]
	public fun mint_and_deposit(user: address, amount: u64, mint_cap: &aptos_framework::coin::MintCapability<AptosCoin>) {
		let dummy_coin = aptos_framework::coin::mint(amount, mint_cap);
		aptos_framework::coin::deposit(user, dummy_coin);
	}

	#[test_only]
	public fun create_user_with_address(addr: address): signer {
		let sig = aptos_framework::account::create_account_for_test(addr);
		aptos_framework::coin::register<DummyCoin>(&sig);
		aptos_framework::coin::register<AptosCoin>(&sig);
		register(&sig);
		sig
	}

	#[test_only]
	fun fetch_order_details(user: &signer, idx: u64) : (u64, u64, u64, u8) acquires UserResource {
		let ur = borrow_global<UserResource>(signer::address_of(user));
		let id = *vector::borrow(&ur.activeOrders, idx);
		(id, order::price(id), order::units(id), order::state(id))
	}

	#[test(user = @resource_account)]
	fun test_registration_working(user: signer) {
		register(&user);
		assert!(exists<UserResource>(signer::address_of(&user)), 0u64);
	}

	#[test(user = @resource_account), expected_failure]
	fun test_unregistered_user_cant_use(user: signer) {
		check_registration(&user);
	}

	#[test(admin = @resource_account)]
	fun test_limit_short_working(admin: signer) acquires ContractStorage, UserResource {
		initialize_module(&admin);
		order::initialize_module(&admin);
		dummy_coin::initialize_module(&admin);

		let user = &create_user_with_address(@0xF00);
		dummy_coin::mint(&admin, signer::address_of(user), 100);

		make_limit_short(user, 100, 10, true);
		limit_short_cancel(user, 1);
	}

	#[test(admin = @resource_account)]
	fun test_limit_long_working(admin: signer) acquires ContractStorage, UserResource {
		initialize_module(&admin);
		order::initialize_module(&admin);
		dummy_coin::initialize_module(&admin);
		let minter = initialize_aptos_coin();

		let user = &create_user_with_address(@0xF00);
		aptos_framework::coin::register<AptosCoin>(user);
		mint_and_deposit(signer::address_of(user), 1000, &minter);

		make_limit_long(user, 100, 5, false);
		limit_long_cancel(user, 1);

		aptos_framework::coin::destroy_mint_cap(minter);
	}

	#[test(admin = @resource_account)]
	fun test_actual_buy_order_matching(admin: signer) acquires ContractStorage, UserResource {
		initialize_module(&admin);
		order::initialize_module(&admin);
		dummy_coin::initialize_module(&admin);
		let mint_cap = initialize_aptos_coin();

		let buyer1 = &create_user_with_address(@0xF001);
		let buyer2 = &create_user_with_address(@0xF002);
		let seller1 = &create_user_with_address(@0xF003);
		let seller2 = &create_user_with_address(@0xF004);

		dummy_coin::mint(&admin, signer::address_of(seller1), 10);
		dummy_coin::mint(&admin, signer::address_of(seller2), 10);
		mint_and_deposit(signer::address_of(buyer1), 1000, &mint_cap);
		mint_and_deposit(signer::address_of(buyer2), 1000, &mint_cap);

		make_limit_short(seller1, 99, 5, false);
		make_limit_short(seller2, 101, 2, true);

		make_limit_long(buyer1, 90, 6, true);
		let (id, _, _, state) = fetch_order_details(buyer1, 0);
		assert!(state == constants::Active(), 0);
		
		limit_long_cancel(buyer1, id);
		assert!(order::state(id) == constants::Cancelled(), 1);

		make_limit_long(buyer1, 100, 6, true);
		let (_, _, _, new_state) = fetch_order_details(buyer1, 0);
		// std::debug::print(&new_state);
		assert!(new_state == constants::Partial(), 2);

		aptos_framework::coin::destroy_mint_cap(mint_cap);
	}

	#[test(admin = @resource_account)]
	fun test_actual_sell_order_matching(admin: signer) acquires ContractStorage, UserResource {
		initialize_module(&admin);
		order::initialize_module(&admin);
		dummy_coin::initialize_module(&admin);
		let mint_cap = initialize_aptos_coin();

		let buyer1 = &create_user_with_address(@0xF001);
		let buyer2 = &create_user_with_address(@0xF002);
		let seller1 = &create_user_with_address(@0xF003);
		let seller2 = &create_user_with_address(@0xF004);

		dummy_coin::mint(&admin, signer::address_of(seller1), 10);
		dummy_coin::mint(&admin, signer::address_of(seller2), 10);
		mint_and_deposit(signer::address_of(buyer1), 1000, &mint_cap);
		mint_and_deposit(signer::address_of(buyer2), 1000, &mint_cap);

		make_limit_long(buyer1, 99, 5, true);
		make_limit_long(buyer2, 101, 2, false);


		make_limit_short(seller1, 105, 6, true);
		let (id, _, _, state) = fetch_order_details(seller1, 0);
		assert!(state == constants::Active(), 0);
		
		limit_short_cancel(seller1, id);
		assert!(order::state(id) == constants::Cancelled(), 1);

		make_limit_short(seller1, 100, 6, true);
		let (_, _, _, state) = fetch_order_details(seller1, 0);
		assert!(state == constants::Partial(), 2);

		aptos_framework::coin::destroy_mint_cap(mint_cap);
	}

}
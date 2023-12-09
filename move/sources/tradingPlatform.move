/**
* Module that will hold all the platform APIs
*/
module resource_account::trading_platform {
	use std::signer;
	use std::vector;
	use resource_account::order::{Self, OrderHeap};
	use aptos_framework::account;
	use aptos_framework::aptos_coin::AptosCoin;
	use resource_account::dummy_coin::DummyCoin;
	use resource_account::constants;

	#[test_only]
	use resource_account::dummy_coin;

	const E_NOT_REGISTERED: u64 = 5;

	struct ContractStorage has key {
		signer_cap: account::SignerCapability,
		sellOrders : OrderHeap,					//	Only active sell orders
		buyOrders : OrderHeap,					//	Only active buy orders
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
	public entry fun sell_request(seller: &signer, price: u64, units: u64, flexible: bool) acquires ContractStorage, UserResource {
		check_registration(seller);
		let contractStore = borrow_global_mut<ContractStorage>(@resource_account);
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

		//	Transfer the Dummy dummy_coin to Resource Account
		aptos_framework::coin::transfer<DummyCoin>(seller, @resource_account, units);
	
		//	Fullfill the order if possible
		let counter_heap = &mut contractStore.buyOrders;
		let (matchedUnits, matches) = order::heap_match(counter_heap, id);
		if (matchedUnits >= units) {
			order::set_state(id, constants::Fulfilled());
			vector::for_each_ref(&matches, |matched_order| {
				let order_id = *matched_order;

				execute_trade(
					order::from(order_id),
					signer::address_of(seller),
					order::price(order_id),
					order::units(order_id),
					contractStore
				);
			
				//	Change in global table
				order::set_state(order_id, constants::Fulfilled());
			});
			if (matchedUnits > units) {
				order::set_state(vector::pop_back(&mut matches), constants::Fulfilled());
			}
		} else if (flexible && matchedUnits != 0) {
			order::set_state(id, constants::Partial());
			vector::for_each_ref(&matches, |matched_order| {
				let order_id = *matched_order;

				execute_trade(
					order::from(order_id),
					signer::address_of(seller),
					order::price(order_id),
					order::units(order_id),
					contractStore
				);
			
				//	Change in global table
				order::set_state(order_id, constants::Fulfilled());
			});
			order::set_units(id, units - matchedUnits);
			order::heap_insert(&mut contractStore.sellOrders, id);
		} else {
			vector::for_each_ref(&matches, |id_ref| {
				order::heap_insert(counter_heap, *id_ref);
			});
			order::heap_insert(&mut contractStore.sellOrders, id);
		};

		//	Add the order's ID to the user's list
		vector::push_back(&mut userStore.activeOrders, id);
	}

	/**
	*	Add a new buy request
	*	for the buyer
	*/
	public entry fun buy_request(buyer: &signer, price: u64, units: u64, flexible: bool) acquires ContractStorage, UserResource {
		check_registration(buyer);
		let contractStore = borrow_global_mut<ContractStorage>(@resource_account);
		let userStore = borrow_global_mut<UserResource>(signer::address_of(buyer));
	
		//	Get a new order
		let id = order::newOrder(
			price,
			units,
			signer::address_of(buyer),
			constants::Buy(),
			flexible,
			constants::Active(),
		);

		//	Transfer the Dummy dummy_coin to Resource Account
		aptos_framework::coin::transfer<AptosCoin>(buyer, @resource_account, price*units);
	
		//	Fullfill the order if possible
		let counter_heap = &mut contractStore.sellOrders;
		let (matchedUnits, matches) = order::heap_match(counter_heap, id);
		if (matchedUnits >= units) {
			order::set_state(id, constants::Fulfilled());
			vector::for_each_ref(&matches, |matched_order| {
				let order_id = *matched_order;

				execute_trade(
					order::from(order_id),
					signer::address_of(buyer),
					order::price(order_id),
					order::units(order_id),
					contractStore
				);

				let leftover = (price - order::price(order_id))*order::units(order_id);
				if (leftover > 0) {
					transfer<AptosCoin>(signer::address_of(buyer), leftover, contractStore);
				};
			
				//	Change in global table
				order::set_state(order_id, constants::Fulfilled());
			});
			if (matchedUnits > units) {
				order::set_state(vector::pop_back(&mut matches), constants::Fulfilled());
			}
		} else if (flexible && matchedUnits != 0) {
			order::set_state(id, constants::Partial());
			vector::for_each_ref(&matches, |matched_order| {
				let order_id = *matched_order;

				execute_trade(
					order::from(order_id),
					signer::address_of(buyer),
					order::price(order_id),
					order::units(order_id),
					contractStore
				);

				let leftover = (price - order::price(order_id))*order::units(order_id);
				if (leftover > 0) {
					transfer<AptosCoin>(signer::address_of(buyer), leftover, contractStore);
				};
			
				//	Change in global table
				order::set_state(order_id, constants::Fulfilled());
			});
			order::set_units(id, units - matchedUnits);
			order::heap_insert(&mut contractStore.buyOrders, id);
		} else {
			vector::for_each_ref(&matches, |id_ref| {
				order::heap_insert(counter_heap, *id_ref);
			});
			order::heap_insert(&mut contractStore.buyOrders, id);
		};

		//	Add the order's ID to the user's list
		vector::push_back(&mut userStore.activeOrders, id);
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
		if (order::type(order_id) == constants::Buy())
			transfer<AptosCoin>(signer::address_of(user), order::price(order_id) * order::units(order_id), storage)
		else
			transfer<DummyCoin>(signer::address_of(user), order::units(order_id), storage)
		;
	}

	fun check_registration(user: &signer) {
		let registered: bool = exists<UserResource>(signer::address_of(user));
		assert!(registered, E_NOT_REGISTERED);
	}

	fun transfer<T>(to: address, amount: u64, storage: &ContractStorage) {
		let resource_signer = &account::create_signer_with_capability(&storage.signer_cap);
		aptos_framework::coin::transfer<T>(resource_signer, to, amount);
	}

	fun execute_trade(buyer: address, seller: address, price: u64, units: u64, storage: &ContractStorage) {
		let apt_transfer_amount = price * units;
		let dummy_transfer_amount = units;

		//	Execute
		transfer<AptosCoin>(seller, apt_transfer_amount, storage);
		transfer<DummyCoin>(buyer, dummy_transfer_amount, storage);
	}

	#[test_only]
	fun initialize_module(admin: &signer) {
		let publisher_sig = &create_user_with_address(@publisher_addr);
		aptos_framework::resource_account::create_resource_account(publisher_sig, vector::empty(), vector::empty());
		init_module(admin);
	}

	#[test_only]
	public fun make_sell_request(user: &signer, price: u64, units: u64, flexible: bool) acquires ContractStorage, UserResource {

		let user_addr = signer::address_of(user);

		let before_len = vector::length(&borrow_global<UserResource>(user_addr).activeOrders);
		let before_bal = aptos_framework::coin::balance<DummyCoin>(user_addr);

		sell_request(user, price, units, flexible);
		
		let after_len = vector::length(&borrow_global<UserResource>(signer::address_of(user)).activeOrders);
		assert!(before_len + 1 == after_len, 0u64);

		let after_bal = aptos_framework::coin::balance<DummyCoin>(user_addr);
		assert!(before_bal - units == after_bal, 1u64);
	}

	#[test_only]
	public fun sell_request_cancel(user: &signer, id: u64) acquires ContractStorage, UserResource {
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
	public fun buy_request_cancel(user: &signer, id: u64) acquires ContractStorage, UserResource {
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
	public fun make_buy_request(user: &signer, price: u64, units: u64, flexible: bool) acquires ContractStorage, UserResource {

		let user_addr = signer::address_of(user);

		let before_len = vector::length(&borrow_global<UserResource>(user_addr).activeOrders);
		let before_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);

		buy_request(user, price, units, flexible);
		
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

	#[test(user = @resource_account), expected_failure(abort_code = E_NOT_REGISTERED)]
	fun test_unregistered_user_cant_use(user: signer) {
		check_registration(&user);
	}

	#[test(admin = @resource_account)]
	fun test_sell_request_working(admin: signer) acquires ContractStorage, UserResource {
		initialize_module(&admin);
		order::initialize_module(&admin);
		dummy_coin::initialize_module(&admin);

		let user = &create_user_with_address(@0xF00);
		dummy_coin::mint(&admin, signer::address_of(user), 100);

		make_sell_request(user, 100, 10, true);
		sell_request_cancel(user, 1);
	}

	#[test(admin = @resource_account)]
	fun test_buy_request_working(admin: signer) acquires ContractStorage, UserResource {
		initialize_module(&admin);
		order::initialize_module(&admin);
		dummy_coin::initialize_module(&admin);
		let minter = initialize_aptos_coin();

		let user = &create_user_with_address(@0xF00);
		aptos_framework::coin::register<AptosCoin>(user);
		mint_and_deposit(signer::address_of(user), 1000, &minter);

		make_buy_request(user, 100, 5, false);
		buy_request_cancel(user, 1);

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

		make_sell_request(seller1, 99, 5, false);
		make_sell_request(seller2, 101, 2, true);

		make_buy_request(buyer1, 90, 6, true);
		let (id, _, _, state) = fetch_order_details(buyer1, 0);
		assert!(state == constants::Active(), 0);
		
		buy_request_cancel(buyer1, id);
		assert!(order::state(id) == constants::Cancelled(), 1);

		make_buy_request(buyer1, 100, 6, true);
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

		make_buy_request(buyer1, 99, 5, true);
		make_buy_request(buyer2, 101, 2, false);


		make_sell_request(seller1, 105, 6, true);
		let (id, _, _, state) = fetch_order_details(seller1, 0);
		assert!(state == constants::Active(), 0);
		
		sell_request_cancel(seller1, id);
		assert!(order::state(id) == constants::Cancelled(), 1);

		make_sell_request(seller1, 100, 6, true);
		let (_, _, _, state) = fetch_order_details(seller1, 0);
		assert!(state == constants::Partial(), 2);

		aptos_framework::coin::destroy_mint_cap(mint_cap);
	}

}
/**
* Module that will hold all the platform APIs
*/
module resource_account::trading_platform {
	use aptos_framework::account;
	use aptos_framework::aptos_coin::AptosCoin;
	use aptos_framework::timestamp;
	use aptos_framework::table::{Self, Table};

	use aptos_std::math64::min;

	use resource_account::constants;
	use resource_account::order::{Self, OrderHeap};	
	use resource_account::position;
	
	use std::error;
	use std::signer;
	use std::vector;

	#[test_only]
	use resource_account::coins::{Self, BTC};

	const ENOT_ENOUGH_FUNDS: u64 = 0;
	const ENOT_ENOUGH_LIQUIDITY: u64 = 1;
	const EMARKET_NOT_FOUND: u64 = 2;

	const ONE_DAY_MS: u64 = 8640000000000;
	const MAX_PRICE: u64 = 0xffffffffffffffff;

	const BUYER_RATIO_NUM: u64 = 1;
	const BUYER_RATIO_DEN: u64 = 2;
	const SELLER_RATIO_NUM: u64 = 2;
	const SELLER_RATIO_DEN: u64 = 1;

	/**
	* Stores the contract's global information like signer_capabilities and expiration time
	*/
	struct ContractStorage has key {
		signer_cap: account::SignerCapability,
		global_expiration_time: u64,
	}

	/**
	* Stores data for a futures market of asset with base for margin and settlement
	*/
	struct Market<phantom base, phantom asset> has key {
		sellOrders : OrderHeap,					//	Only active sell orders
		buyOrders : OrderHeap,					//	Only active buy orders
		price: u64,
		transactions: vector<Transaction>,
		expiration_prices: Table<u64, u64>,
	}

	struct Transaction has store, copy {
		timestamp: u64,
		price: u64,
	}

	struct UserResource<phantom base, phantom asset> has key {	
		orders: vector<u64>,
	}

	/**
	* Initialize by retrieving and storing the signer_capability
	*/
	entry fun init_module(admin: &signer) {
		let signer_cap = aptos_framework::resource_account::retrieve_resource_account_cap(admin, @publisher_addr);

		move_to(admin, ContractStorage {
			signer_cap: signer_cap,
			global_expiration_time: timestamp::now_microseconds() + ONE_DAY_MS,
		});
	}

	/**
	* Register a new user by creating a resource under his address
	*/
	public entry fun register<base, asset>(sender: &signer) {
		let user_resource = UserResource<base, asset> {
			orders: vector<u64>[],
		};

		move_to(sender, user_resource);
	}

	/**
	* Add a new limit sell request for the seller
	*/
	public entry fun limit_short<base, asset>(seller: &signer, price: u64, units: u64, flexible: bool) 
		acquires ContractStorage, UserResource, Market {
		check_registration<base, asset>(seller);
		create_market_if_not_exists<base, asset>();
		let expiration_time = check_and_update_expiration<base, asset>();

		let market = borrow_global_mut<Market<base, asset>>(@resource_account);
		let userStore = borrow_global_mut<UserResource<base, asset>>(signer::address_of(seller));
	
		//	Get a new order
		let id = order::newOrder(
			price,
			units,
			signer::address_of(seller),
			constants::Limit(),
			flexible,
			constants::Active(),
			constants::Short(),
			expiration_time,
		);

		//	Add the order's ID to the user's list
		vector::push_back(&mut userStore.orders, id);

		//	Fullfill the order if possible
		let margin_amount = 0u64;
		let tbe_order = vector<u64>[];
		let tbe_price = vector<u64>[];
		let tbe_units = vector<u64>[];

		let counter_heap = &mut market.buyOrders;
		let (matchedUnits, matches) = order::heap_match(counter_heap, id);
		if (matchedUnits >= units) {
			order::set_state(id, constants::Filled());

			vector::for_each(matches, |matched_order| {
				let strike_units = min(units, order::units(matched_order));

				vector::push_back(&mut tbe_order, matched_order);
				vector::push_back(&mut tbe_price, order::price(matched_order));
				vector::push_back(&mut tbe_units, strike_units);

				margin_amount = margin_amount + calculate_seller_margin(order::price(matched_order), strike_units);
				units = units - strike_units;
				if (strike_units == order::units(matched_order))
					order::set_state(matched_order, constants::Filled())
				else
					order::set_state(matched_order, constants::Partial())
				;
			});
		} else if (flexible && matchedUnits != 0) {
			vector::for_each(matches, |matched_order| {
				let strike_units = min(units, order::units(matched_order));

				vector::push_back(&mut tbe_order, matched_order);
				vector::push_back(&mut tbe_price, order::price(matched_order));
				vector::push_back(&mut tbe_units, strike_units);

				margin_amount = margin_amount + calculate_seller_margin(order::price(matched_order), strike_units);
				units = units - strike_units;
				if (strike_units == order::units(matched_order))
					order::set_state(matched_order, constants::Filled())
				else
					order::set_state(matched_order, constants::Partial())
				;
			});
		
			order::set_state(id, constants::Partial());
			order::set_units(id, units);
			order::heap_insert(&mut market.sellOrders, id);
		} else {
			vector::for_each(matches, |match_id| {
				order::heap_insert(counter_heap, match_id);
			});
			order::heap_insert(&mut market.sellOrders, id);
		};


		margin_amount = margin_amount + calculate_seller_margin(price, units);
		let success = try_and_acquire(seller, margin_amount);

		if (!success) {
			order::set_state(id, constants::Failed());
			abort error::resource_exhausted(ENOT_ENOUGH_FUNDS)
		};

		order::deposit_margin(id, margin_amount);
		while (vector::length(&tbe_order) != 0) {
			execute_trade<base, asset>(
				vector::pop_back(&mut tbe_order),
				id,
				vector::pop_back(&mut tbe_price),
				vector::pop_back(&mut tbe_units),
				market,
			)
		}
	}

	/**
	*	Add a new buy request
	*	for the buyer
	*/
	public entry fun limit_long<base, asset>(buyer: &signer, price: u64, units: u64, flexible: bool)
		acquires ContractStorage, UserResource, Market {
		check_registration<base, asset>(buyer);
		create_market_if_not_exists<base, asset>();
		let expiration_time = check_and_update_expiration<base, asset>();
	
		let market = borrow_global_mut<Market<base, asset>>(@resource_account);
		let userStore = borrow_global_mut<UserResource<base, asset>>(signer::address_of(buyer));
	
		//	Get a new order
		let id = order::newOrder(
			price,
			units,
			signer::address_of(buyer),
			constants::Limit(),
			flexible,
			constants::Active(),
			constants::Long(),
			expiration_time,
		);

		//	Add the order's ID to the user's list
		vector::push_back(&mut userStore.orders, id);
	
		//	Fullfill the order if possible
		let margin_amount = 0u64;
		let tbe_order = vector<u64>[];
		let tbe_price = vector<u64>[];
		let tbe_units = vector<u64>[];

		let counter_heap = &mut market.sellOrders;
		let (matchedUnits, matches) = order::heap_match(counter_heap, id);
		if (matchedUnits >= units) {
			order::set_state(id, constants::Filled());

			vector::for_each(matches, |matched_order| {
				let strike_units = min(units, order::units(matched_order));
			
				vector::push_back(&mut tbe_order, matched_order);
				vector::push_back(&mut tbe_price, order::price(matched_order));
				vector::push_back(&mut tbe_units, strike_units);

				margin_amount = margin_amount + calculate_buyer_margin(order::price(matched_order), strike_units);
				units = units - strike_units;

				if (strike_units == order::units(matched_order))
					order::set_state(matched_order, constants::Filled())
				else
					order::set_state(matched_order, constants::Partial())
				;
			});
		} else if (flexible && matchedUnits != 0) {
			vector::for_each(matches, |matched_order| {
				let strike_units = min(units, order::units(matched_order));

				vector::push_back(&mut tbe_order, matched_order);
				vector::push_back(&mut tbe_price, order::price(matched_order));
				vector::push_back(&mut tbe_units, strike_units);

				margin_amount = margin_amount + calculate_buyer_margin(order::price(matched_order), strike_units);
				units = units - strike_units;

				if (strike_units == order::units(matched_order))
					order::set_state(matched_order, constants::Filled())
				else
					order::set_state(matched_order, constants::Partial())
				;
			});
		
			order::set_state(id, constants::Partial());
			order::set_units(id, units);
			order::heap_insert(&mut market.buyOrders, id);
		} else {
			vector::for_each(matches, |match_id| {
				order::heap_insert(counter_heap, match_id);
			});
			order::heap_insert(&mut market.buyOrders, id);
		};

		
		margin_amount = margin_amount + calculate_buyer_margin(price, units);
		let success = try_and_acquire(buyer, margin_amount);

		if (!success) {
			order::set_state(id, constants::Failed());
			abort error::resource_exhausted(ENOT_ENOUGH_FUNDS)
		};

		order::deposit_margin(id, margin_amount);
		while (vector::length(&tbe_order) != 0) {
			execute_trade<base, asset>(
				id,
				vector::pop_back(&mut tbe_order),
				vector::pop_back(&mut tbe_price),
				vector::pop_back(&mut tbe_units),
				market,
			)
		}
	}

	public entry fun market_long<base, asset>(buyer: &signer, amount: u64)
		acquires ContractStorage, UserResource, Market {
		check_registration<base, asset>(buyer);
		create_market_if_not_exists<base, asset>();
		let expiration_time = check_and_update_expiration<base, asset>();
	
		let market = borrow_global_mut<Market<base, asset>>(@resource_account);

		assert!(fetch_balance(signer::address_of(buyer)) >= amount, error::resource_exhausted(ENOT_ENOUGH_FUNDS));
		
		if (order::heap_is_empty(&market.sellOrders)) return;

		let top = order::heap_head(&mut market.sellOrders);
		let best_price = order::price(top);
		let dummy_order = create_new_order_for<base, asset>(
			signer::address_of(buyer),
			MAX_PRICE,
			maximum_buy_units(amount, best_price),
			constants::Market(),
			true,
			constants::Active(),
			constants::Long(),
			expiration_time,
		);

		let (_, matched) = order::heap_match(&mut market.sellOrders, dummy_order);
		let units = 0u64;
		vector::for_each(matched, |matched_order| {
			let strike_price = order::price(matched_order);
			let strike_units = min(maximum_buy_units(amount, strike_price), order::units(matched_order));
			let exit = false;

			if (!order::is_flexible(matched_order) && order::units(matched_order) != strike_units) {
				put_back(&mut market.sellOrders, matched_order);
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
				order::deposit_margin(dummy_order, margin);
				execute_trade<base, asset>(
					dummy_order,
					matched_order,
					strike_price,
					strike_units,
					market,
				);
			};

			if (!exit) {
				units = units + strike_units ;
				if (strike_units == order::units(matched_order)) {
					order::set_state(matched_order, constants::Filled());
				} else {
					order::set_units(matched_order, order::units(matched_order) - strike_units);
					order::set_state(matched_order, constants::Partial());
					put_back(&mut market.sellOrders, matched_order);
				};
			};

			if (!exit) {
				amount = amount - margin;
			}
		});

		order::set_units(dummy_order, units);
		order::set_state(dummy_order, constants::Filled());
	}

	public entry fun market_long_units<base, asset>(buyer: &signer, num_units: u64)
		acquires ContractStorage, UserResource, Market {
		check_registration<base, asset>(buyer);
		create_market_if_not_exists<base, asset>();
		let expiration_time = check_and_update_expiration<base, asset>();
	
		let market = borrow_global_mut<Market<base, asset>>(@resource_account);

		let dummy_order = create_new_order_for<base, asset>(
			signer::address_of(buyer),
			MAX_PRICE,
			num_units,
			constants::Market(),
			true,
			constants::Active(),
			constants::Short(),
			expiration_time,
		);

		let (_, matched) = order::heap_match(&mut market.sellOrders, dummy_order);

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
					put_back(&mut market.sellOrders, matched_order);
					exit = true;
				};
			};
			
			if (!exit && strike_units == 0) {
				put_back(&mut market.sellOrders, matched_order);
				exit = true;
			};

			if (!exit) {
				order::deposit_margin(dummy_order, margin);
				execute_trade<base, asset>(
					dummy_order,
					matched_order,
					strike_price,
					strike_units,
					market,
				);
			};
			
			if (!exit) {
				if (strike_units == order::units(matched_order)) {
					order::set_state(matched_order, constants::Filled());
				} else {
					order::set_state(matched_order, constants::Partial());
					order::set_units(matched_order, order::units(matched_order) - strike_price);
					put_back(&mut market.sellOrders, matched_order);
				};
			};

			if (!exit) {
				left = left - strike_units;
			}
		});

		order::set_units(dummy_order, num_units - left);
	}

	public entry fun market_short<base, asset>(seller: &signer, amount: u64)
		acquires ContractStorage, UserResource, Market {
		check_registration<base, asset>(seller);
		create_market_if_not_exists<base, asset>();
		let expiration_time = check_and_update_expiration<base, asset>();
	
		let market = borrow_global_mut<Market<base, asset>>(@resource_account);

		assert!(fetch_balance(signer::address_of(seller)) >= amount, error::resource_exhausted(ENOT_ENOUGH_FUNDS));
		
		if (order::heap_is_empty(&market.buyOrders)) return;

		let top = order::heap_head(&mut market.buyOrders);
		let best_price = order::price(top);
		let dummy_order = create_new_order_for<base, asset>(
			signer::address_of(seller),
			0,
			maximum_sell_units(amount, best_price),
			constants::Market(),
			true,
			constants::Active(),
			constants::Short(),
			expiration_time,
		);

		let (_, matched) = order::heap_match(&mut market.buyOrders, dummy_order);
		let units = 0u64;
		vector::for_each(matched, |matched_order| {
			let strike_price = order::price(matched_order);
			let strike_units = min(maximum_sell_units(amount, strike_price), order::units(matched_order));
			let exit = false;

			if (!order::is_flexible(matched_order) && order::units(matched_order) != strike_units) {
				put_back(&mut market.buyOrders, matched_order);
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
				order::deposit_margin(dummy_order, margin);
				units = units + strike_units ;
				execute_trade<base, asset>(
					matched_order,
					dummy_order,
					strike_price,
					strike_units,
					market,
				);
			};

			if (!exit) {
				if (strike_units == order::units(matched_order)) {
					order::set_state(matched_order, constants::Filled());
				} else {
					order::set_units(matched_order, order::units(matched_order) - strike_units);
					order::set_state(matched_order, constants::Partial());
					put_back(&mut market.buyOrders, matched_order);
				};
			};

			if (!exit) {
				amount = amount - margin;
			}
		});

		order::set_units(dummy_order, units);
		order::set_state(dummy_order, constants::Filled());
	}

	public entry fun market_short_units<base, asset>(seller: &signer, num_units: u64)
		acquires ContractStorage, UserResource, Market {
		check_registration<base, asset>(seller);
		create_market_if_not_exists<base, asset>();
		let expiration_time = check_and_update_expiration<base, asset>();
	
		let market = borrow_global_mut<Market<base, asset>>(@resource_account);

		let dummy_order = create_new_order_for<base, asset>(
			signer::address_of(seller),
			0,
			num_units,
			constants::Market(),
			true,
			constants::Active(),
			constants::Short(),
			expiration_time,
		);

		let (_, matched) = order::heap_match(&mut market.buyOrders, dummy_order);

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
					put_back(&mut market.buyOrders, matched_order) ;
					exit = true;
				};
			};
			
			if (!exit && strike_units == 0) {
				put_back(&mut market.buyOrders, matched_order);
				exit = true;
			};

			if (!exit) {
				order::deposit_margin(dummy_order, margin);
				execute_trade<base, asset>(
					matched_order,
					dummy_order,
					strike_price,
					strike_units,
					market,
				);
			};

			if (!exit) {
				if (strike_units == order::units(matched_order)) {
					order::set_state(matched_order, constants::Filled());
				} else {
					order::set_state(matched_order, constants::Partial());
					order::set_units(matched_order, order::units(matched_order) - strike_units);
					put_back(&mut market.buyOrders, matched_order);
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
	public entry fun cancel_request<base, asset>(user: &signer, order_id: u64) acquires ContractStorage, Market {
		check_registration<base, asset>(user);
		create_market_if_not_exists<base, asset>();
		check_and_update_expiration<base, asset>();

		let storage = borrow_global<ContractStorage>(@resource_account);

		//	Change Order's state to cancelled
		order::set_state(order_id, constants::Cancelled());

		//	Return the token back to user
		let price = order::price(order_id);
		let units = order::units(order_id);
		let margin = if (order::is_long(order_id))
			calculate_buyer_margin(price, units)
		else
			calculate_seller_margin(price, units)
		;

		transfer_to<base>(signer::address_of(user), margin, storage);
	}

	public entry fun close_order<base, asset>(user: &signer, order_id: u64)
		acquires ContractStorage, UserResource, Market {

		check_registration<base, asset>(user);
		create_market_if_not_exists<base, asset>();
		check_and_update_expiration<base, asset>();

		vector::remove_value(&mut borrow_global_mut<UserResource<base, asset>>(signer::address_of(user)).orders, &order_id);
		order::set_state(order_id, constants::Cancelled());

		let storage = borrow_global_mut<ContractStorage>(@resource_account);
		let market = borrow_global_mut<Market<base, asset>>(@resource_account);
		let (total_strike_units, total_stake) = {
			let strike_units = 0u64;
			let stake = 0u64;
			vector::for_each(order::list_positions(order_id), |pos| {
				strike_units = strike_units + position::strike_units(pos);
				stake = stake + position::strike_price(pos) * position::strike_units(pos);
			});
			(strike_units, stake)
		};
		let total_deposited_margin = order::margin_deposits(order_id);


		// Assuming margin always stays positive
		if (!order::is_expired(order_id)) {
			if (order::is_long(order_id)) {

				let dummy_order = order::newOrder(
					0,
					total_strike_units,
					@resource_account,
					constants::Market(),
					true,
					constants::Active(),
					constants::Short(),
					order::expiry(order_id),
				);

				let (m_units, m_orders) = order::heap_match(&mut market.buyOrders, dummy_order);
				if (m_units >= total_strike_units) {
					let quotation = 0u64;
					vector::for_each_ref(&m_orders, |id_ref| {
						let order = *id_ref;
						order::set_state(order, constants::Filled());
						quotation = quotation + (order::price(order)*order::units(order));
					});

					if (m_units > total_strike_units) {
						let last = *vector::borrow(&m_orders, vector::length(&m_orders)-1);
						quotation = quotation - (order::price(last)*(m_units - total_strike_units));
						order::set_units(last, m_units - total_strike_units);
						order::set_state(last, constants::Partial());
						order::heap_insert(&mut market.buyOrders, last);
					};

					let final_margin = (total_deposited_margin + quotation) - total_stake;
					transfer_to<base>(signer::address_of(user), final_margin, storage);
				} else {
					abort error::invalid_state(ENOT_ENOUGH_LIQUIDITY)
				};
			} else {
				let dummy_order = order::newOrder(
					MAX_PRICE,
					total_strike_units,
					@resource_account,
					constants::Market(),
					true,
					constants::Active(),
					constants::Long(),
					order::expiry(order_id),
				);

				let (m_units, m_orders) = order::heap_match(&mut market.sellOrders, dummy_order);
				if (m_units >= total_strike_units) {
					let quotation = 0u64;
					vector::for_each_ref(&m_orders, |id_ref| {
						let order = *id_ref;
						order::set_state(order, constants::Filled());
						quotation = quotation + (order::price(order)*order::units(order));
					});

					if (m_units > total_strike_units) {
						let last = *vector::borrow(&m_orders, vector::length(&m_orders)-1);
						quotation = quotation - (order::price(last)*(m_units - total_strike_units));
						order::set_units(last, m_units - total_strike_units);
						order::set_state(last, constants::Partial());
						order::heap_insert(&mut market.sellOrders, last);
					};

					let final_margin = (total_deposited_margin + total_stake) - quotation;
					transfer_to<base>(signer::address_of(user), final_margin, storage);
				} else {
					abort error::invalid_state(ENOT_ENOUGH_LIQUIDITY)
				};
			};
		} else {
			let market_price = *table::borrow(&market.expiration_prices, order::expiry(order_id));
			if(order::is_long(order_id)) {
				let margin = (total_deposited_margin + (market_price * total_strike_units)) - total_stake;
				transfer_to<base>(signer::address_of(user), margin, storage);
			} else {
				let margin = (total_deposited_margin + total_stake - (market_price * total_strike_units));
				transfer_to<base>(signer::address_of(user), margin, storage);
			}
		};

	}

	public entry fun refill_margin(user: &signer, order_id: u64, amount: u64) {
		let success = try_and_acquire(user, amount);
		if (success) {
			order::deposit_margin(order_id, amount);
		};
	}

	#[view]
	public fun market_price<base, asset>(): u64 acquires Market {
		assert!(exists<Market<base,asset>>(@resource_account), error::not_found(EMARKET_NOT_FOUND));
		borrow_global<Market<base, asset>>(@resource_account).price
	}

	#[view]
	public fun price_history<base,asset>(from: u64): vector<Transaction> acquires Market {
		let market = borrow_global<Market<base, asset>>(@resource_account);
		market.transactions
	}

	inline fun check_registration<base, asset>(user: &signer) {
		assert!(exists<UserResource<base, asset>>(signer::address_of(user)), error::permission_denied(0));
	}

	fun create_market_if_not_exists<base, asset>() acquires ContractStorage {
		let admin = &account::create_signer_with_capability(
			&borrow_global<ContractStorage>(@resource_account).signer_cap
		);
		if (!exists<Market<base, asset>>(@resource_account)) {
			aptos_framework::coin::register<asset>(admin);
			aptos_framework::coin::register<base>(admin);
			move_to(admin, Market<base, asset>{
				sellOrders: order::MinHeap(),
				buyOrders: order::MaxHeap(),
				expiration_prices: table::new<u64, u64>(),
				transactions: vector<Transaction>[],
				price: 0u64,
			})
		};
	}

	fun check_and_update_expiration<base, asset>(): u64 acquires ContractStorage, Market {
		let storage = borrow_global_mut<ContractStorage>(@resource_account);
		let market = borrow_global_mut<Market<base, asset>>(@resource_account);
		let now = timestamp::now_microseconds();
		if (now >= storage.global_expiration_time) {
			table::add(&mut market.expiration_prices, storage.global_expiration_time, market.price);
			let delta = ((now - storage.global_expiration_time)/ONE_DAY_MS)*ONE_DAY_MS + ONE_DAY_MS ;
			storage.global_expiration_time = storage.global_expiration_time + delta;
		};
		storage.global_expiration_time
	}

	inline fun fetch_balance(addr: address): u64 {
		aptos_framework::coin::balance<AptosCoin>(addr)
	}

	inline fun add_to_orders<base, asset>(user: address, order: u64) acquires UserResource {
		vector::push_back(&mut borrow_global_mut<UserResource<base, asset>>(user).orders, order);
	}

	inline fun create_new_order_for<base, asset>(
		user: address,
		price: u64,
		units: u64,
		type: u8,
		flexible: bool,
		state: u8,
		position: u8,
		expiration_time: u64,
	): u64 acquires UserResource {
		let order = order::newOrder(
			price,
			units,
			user,
			type,
			flexible,
			state,
			position,
			expiration_time,
		);
		add_to_orders<base, asset>(user, order);
		order
	}

	inline fun calculate_buyer_margin(strike_price: u64, strike_units: u64): u64 {
		BUYER_RATIO_NUM * (strike_price * strike_units) / BUYER_RATIO_DEN
	}

	inline fun calculate_seller_margin(strike_price: u64, strike_units: u64): u64 {
		SELLER_RATIO_NUM * (strike_price * strike_units) / SELLER_RATIO_DEN
	}

	inline fun maximum_buy_units(amount: u64, strike_price: u64): u64 {
		(BUYER_RATIO_DEN * amount / BUYER_RATIO_NUM) / strike_price
	}

	inline fun maximum_sell_units(amount: u64, strike_price: u64): u64 {
		(SELLER_RATIO_DEN * amount / SELLER_RATIO_NUM) / strike_price
	}

	inline fun put_back(heap: &mut OrderHeap, order: u64) {
		order::heap_insert(heap, order);
	}

	fun transfer_to<coin>(to: address, amount: u64, storage: &ContractStorage) {
		let resource_signer = &account::create_signer_with_capability(&storage.signer_cap);
		aptos_framework::coin::transfer<coin>(resource_signer, to, amount);
	}

	fun transfer_from<coin>(from: &signer, amount: u64) {
		aptos_framework::coin::transfer<coin>(from, @resource_account, amount);
	}

	fun try_and_acquire(from: &signer, amount: u64): bool {
		let balance = fetch_balance(signer::address_of(from));

		if (balance < amount) {
			return false
		};

		aptos_framework::coin::transfer<AptosCoin>(from, @resource_account, amount);
		return true
	}

	fun execute_trade<base, asset>(buy_order: u64, sell_order: u64, price: u64, units: u64, market: &mut Market<base, asset>) {
		//	Create Positions
		create_position_for(
			buy_order,
			price,
			units,
		);
		create_position_for(
			sell_order,
			price,
			units,
		);

		vector::push_back(&mut market.transactions, Transaction {
			timestamp: timestamp::now_microseconds(),
			price,
		});
		market.price = price;
	}

	inline fun is_market_order(order: u64): bool {
		order::price(order) == MAX_PRICE || order::price(order) == 0
	}

	inline fun create_position_for(order: u64, strike_price: u64, strike_units: u64): u64 {
		let pos = position::open_position(order, strike_price, strike_units);
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
	public fun make_limit_short(user: &signer, price: u64, units: u64, flexible: bool) acquires ContractStorage, UserResource, Market {

		let user_addr = signer::address_of(user);
		let before_len = vector::length(&borrow_global<UserResource<AptosCoin, BTC>>(user_addr).orders);

		limit_short<AptosCoin, BTC>(user, price, units, flexible);
		
		let after_len = vector::length(&borrow_global<UserResource<AptosCoin, BTC>>(user_addr).orders);
		assert!(before_len + 1 == after_len, 0u64);
	}

	#[test_only]
	public fun make_market_short(user: &signer, amount: u64) acquires ContractStorage, UserResource, Market {

		let user_addr = signer::address_of(user);
		let before_len = vector::length(&borrow_global<UserResource<AptosCoin, BTC>>(user_addr).orders);

		let before_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);

		market_short<AptosCoin, BTC>(user, amount);
		
		let after_len = vector::length(&borrow_global<UserResource<AptosCoin, BTC>>(user_addr).orders);
		assert!(before_len + 1 == after_len, 0u64);

		let after_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);
		assert!(before_bal <= after_bal + amount, 1u64);
	}

	#[test_only]
	public fun limit_short_cancel(user: &signer, id: u64) acquires ContractStorage, Market {
		let user_addr = signer::address_of(user);
		let before_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);

		cancel_request<AptosCoin, BTC>(user, id);

		let after_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);
		assert!(before_bal + calculate_seller_margin(order::price(id), order::units(id)) == after_bal, 1u64);
	}

	#[test_only]
	public fun limit_long_cancel(user: &signer, id: u64) acquires ContractStorage, Market {
		let user_addr = signer::address_of(user);
		let before_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);
		
		cancel_request<AptosCoin, BTC>(user, id);

		let after_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);
		assert!(before_bal + calculate_buyer_margin(order::price(id), order::units(id)) == after_bal, 1u64);
	}

	#[test_only]
	public fun make_limit_long(user: &signer, price: u64, units: u64, flexible: bool) acquires ContractStorage, UserResource, Market {

		let user_addr = signer::address_of(user);

		let before_len = vector::length(&borrow_global<UserResource<AptosCoin, BTC>>(user_addr).orders);
		let before_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);

		limit_long<AptosCoin, BTC>(user, price, units, flexible);
		
		let after_len = vector::length(&borrow_global<UserResource<AptosCoin, BTC>>(signer::address_of(user)).orders);
		assert!(before_len + 1 == after_len, 0u64);

		let after_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);
		assert!(before_bal != after_bal, 1u64);
	}

	#[test_only]
	public fun make_market_long(user: &signer, amount: u64) acquires ContractStorage, UserResource, Market {

		let user_addr = signer::address_of(user);
		let before_len = vector::length(&borrow_global<UserResource<AptosCoin, BTC>>(user_addr).orders);

		let before_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);

		market_long<AptosCoin, BTC>(user, amount);
		
		let after_len = vector::length(&borrow_global<UserResource<AptosCoin, BTC>>(user_addr).orders);
		assert!(before_len + 1 == after_len, 0u64);

		let after_bal = aptos_framework::coin::balance<AptosCoin>(user_addr);
		assert!(before_bal <= after_bal + amount, 1u64);
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
		aptos_framework::coin::register<BTC>(&sig);
		aptos_framework::coin::register<AptosCoin>(&sig);
		register<AptosCoin, BTC>(&sig);
		sig
	}

	#[test_only]
	fun fetch_order_details(user: &signer, idx: u64) : (u64, u64, u64, u8) acquires UserResource {
		let ur = borrow_global<UserResource<AptosCoin, BTC>>(signer::address_of(user));
		let id = *vector::borrow(&ur.orders, idx);
		(id, order::price(id), order::units(id), order::state(id))
	}

	#[test_only]
	fun setup(admin: &signer) {
		order::initialize_module(admin);
		position::initialize_module(admin);
		coins::initialize_module(admin);
		initialize_module(admin);
	}

	#[test_only]
	fun balance(user: address): u64 {
		aptos_framework::coin::balance<AptosCoin>(user)
	}

	#[test(user = @resource_account)]
	fun test_registration_working(user: signer) {
		register<AptosCoin, BTC>(&user);
		assert!(exists<UserResource<AptosCoin, BTC>>(signer::address_of(&user)), 0u64);
	}

	#[test(user = @resource_account), expected_failure]
	fun test_unregistered_user_cant_use(user: signer) {
		check_registration<AptosCoin, BTC>(&user);
	}

	#[test(admin = @resource_account)]
	fun test_limit_short_working(admin: signer) acquires ContractStorage, UserResource, Market {
		setup(&admin);
		let mint_cap = initialize_aptos_coin();

		let user = &create_user_with_address(@0xF00);
		mint_and_deposit(signer::address_of(user), 1000, &mint_cap);

		make_limit_short(user, 100, 5, true);
		limit_short_cancel(user, 1);

		aptos_framework::coin::destroy_mint_cap(mint_cap);
	}

	#[test(admin = @resource_account)]
	fun test_limit_long_working(admin: signer) acquires ContractStorage, UserResource, Market {
		setup(&admin);
		let minter = initialize_aptos_coin();

		let user = &create_user_with_address(@0xF00);
		aptos_framework::coin::register<AptosCoin>(user);
		mint_and_deposit(signer::address_of(user), 1000, &minter);

		make_limit_long(user, 100, 5, false);
		limit_long_cancel(user, 1);

		aptos_framework::coin::destroy_mint_cap(minter);
	}

	#[test(admin = @resource_account)]
	fun test_actual_buy_order_matching(admin: signer) acquires ContractStorage, UserResource , Market{
		setup(&admin);
		let mint_cap = initialize_aptos_coin();

		let buyer1 = &create_user_with_address(@0xF001);
		let buyer2 = &create_user_with_address(@0xF002);
		let seller1 = &create_user_with_address(@0xF003);
		let seller2 = &create_user_with_address(@0xF004);

		mint_and_deposit(signer::address_of(seller1), 1000, &mint_cap);
		mint_and_deposit(signer::address_of(seller2), 1000, &mint_cap);
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
		let (_, _, _, new_state) = fetch_order_details(buyer1, 1);
		assert!(new_state == constants::Partial(), 2);

		aptos_framework::coin::destroy_mint_cap(mint_cap);
	}

	#[test(admin = @resource_account)]
	fun test_actual_sell_order_matching(admin: signer) acquires ContractStorage, UserResource , Market{
		setup(&admin);
		let mint_cap = initialize_aptos_coin();

		let buyer1 = &create_user_with_address(@0xF001);
		let buyer2 = &create_user_with_address(@0xF002);
		let seller1 = &create_user_with_address(@0xF003);
		let seller2 = &create_user_with_address(@0xF004);

		mint_and_deposit(signer::address_of(seller1), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(seller2), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(buyer1), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(buyer2), 2000, &mint_cap);

		make_limit_long(buyer1, 99, 5, true);
		make_limit_long(buyer2, 101, 2, false);


		make_limit_short(seller1, 105, 6, true);
		let (id, _, _, state) = fetch_order_details(seller1, 0);
		assert!(state == constants::Active(), 0);
		
		limit_short_cancel(seller1, id);
		assert!(order::state(id) == constants::Cancelled(), 1);

		make_limit_short(seller1, 100, 6, true);
		let (_, _, _, state) = fetch_order_details(seller1, 1);
		assert!(state == constants::Partial(), 2);

		aptos_framework::coin::destroy_mint_cap(mint_cap);
	}

	#[test(admin = @resource_account)]
	fun test_actual_market_sell_order_matching(admin: signer) acquires ContractStorage, UserResource , Market{
		setup(&admin);
		let mint_cap = initialize_aptos_coin();

		let buyer1 = &create_user_with_address(@0xF001);
		let buyer2 = &create_user_with_address(@0xF002);
		let buyer3 = &create_user_with_address(@0xF004);
		let seller1 = &create_user_with_address(@0xF003);

		mint_and_deposit(signer::address_of(seller1), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(buyer1), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(buyer2), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(buyer3), 2000, &mint_cap);

		make_limit_long(buyer1, 99, 5, true);
		make_limit_long(buyer2, 101, 2, false);
		make_limit_long(buyer3, 100, 8, false);


		make_market_short(seller1, 2000);
		assert!(aptos_framework::coin::balance<AptosCoin>(signer::address_of(seller1)) == 606, 0u64);

		let (_, _, _, state) = fetch_order_details(seller1, 0);
		assert!(state == constants::Filled(), 1);

		let (_, _, _, state) = fetch_order_details(buyer1, 0);
		assert!(state == constants::Filled(), 2);

		let (_, _, _, state) = fetch_order_details(buyer2, 0);
		assert!(state == constants::Filled(), 3);

		let (_, _, _, state) = fetch_order_details(buyer3, 0);
		assert!(state == constants::Active(), 4);

		aptos_framework::coin::destroy_mint_cap(mint_cap);
	}

	#[test(admin = @resource_account)]
	fun test_actual_market_buy_order_matching(admin: signer) acquires ContractStorage, UserResource , Market{
		setup(&admin);
		let mint_cap = initialize_aptos_coin();

		let seller1 = &create_user_with_address(@0xF001);
		let seller2 = &create_user_with_address(@0xF002);
		let seller3 = &create_user_with_address(@0xF004);
		let buyer1 = &create_user_with_address(@0xF003);

		mint_and_deposit(signer::address_of(buyer1), 500, &mint_cap);
		mint_and_deposit(signer::address_of(seller1), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(seller2), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(seller3), 2000, &mint_cap);

		make_limit_short(seller1, 99, 5, true);
		make_limit_short(seller2, 101, 2, false);
		make_limit_short(seller3, 100, 8, false);


		make_market_long(buyer1, 500);

		let bal = aptos_framework::coin::balance<AptosCoin>(signer::address_of(buyer1));
		assert!(bal == 152, 0u64);

		let (_, _, _, state) = fetch_order_details(buyer1, 0);
		assert!(state == constants::Filled(), 1);

		let (_, _, _, state) = fetch_order_details(seller1, 0);
		assert!(state == constants::Filled(), 2);

		let (_, _, _, state) = fetch_order_details(seller2, 0);
		assert!(state == constants::Filled(), 3);

		let (_, _, _, state) = fetch_order_details(seller3, 0);
		assert!(state == constants::Active(), 4);

		aptos_framework::coin::destroy_mint_cap(mint_cap);
	}

	#[test(admin = @resource_account)]
	fun test_actual_closing_buy_order(admin: signer) acquires ContractStorage, UserResource , Market{
		setup(&admin);
		let mint_cap = initialize_aptos_coin();

		let seller1 = &create_user_with_address(@0xF001);
		let seller2 = &create_user_with_address(@0xF002);
		let seller3 = &create_user_with_address(@0xF003);
		let buyer1 = &create_user_with_address(@0xF004);
		let buyer2 = &create_user_with_address(@0xF005);
		let buyer3 = &create_user_with_address(@0xF006);

		mint_and_deposit(signer::address_of(buyer1), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(buyer2), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(buyer3), 500, &mint_cap);
		mint_and_deposit(signer::address_of(seller1), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(seller2), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(seller3), 2000, &mint_cap);

		make_limit_short(seller1, 99, 5, true);
		make_limit_short(seller2, 101, 2, false);
		make_limit_short(seller3, 100, 8, false);
		make_limit_long(buyer1, 97, 3, true);
		make_limit_long(buyer2, 98, 4, false);


		make_market_long(buyer3, 500);

		let bal = aptos_framework::coin::balance<AptosCoin>(signer::address_of(buyer3));
		assert!(bal == 152, 0u64);

		let (_, _, _, state) = fetch_order_details(buyer3, 0);
		assert!(state == constants::Filled(), 1);

		let (_, _, _, state) = fetch_order_details(seller1, 0);
		assert!(state == constants::Filled(), 2);

		let (_, _, _, state) = fetch_order_details(seller2, 0);
		assert!(state == constants::Filled(), 3);

		let (_, _, _, state) = fetch_order_details(seller3, 0);
		assert!(state == constants::Active(), 4);

		close_order<AptosCoin, BTC>(buyer3, 6);

		let bal = aptos_framework::coin::balance<AptosCoin>(signer::address_of(buyer3));
		assert!(bal == 486, 6);

		aptos_framework::coin::destroy_mint_cap(mint_cap);
	}

	#[test(admin = @resource_account)]
	fun test_actual_closing_sell_order(admin: signer) acquires ContractStorage, UserResource , Market{
		setup(&admin);
		let mint_cap = initialize_aptos_coin();

		let seller1 = &create_user_with_address(@0xF001);
		let seller2 = &create_user_with_address(@0xF002);
		let seller3 = &create_user_with_address(@0xF003);
		let buyer1 = &create_user_with_address(@0xF004);
		let buyer2 = &create_user_with_address(@0xF005);
		let buyer3 = &create_user_with_address(@0xF006);

		mint_and_deposit(signer::address_of(buyer1), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(buyer2), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(buyer3), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(seller1), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(seller2), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(seller3), 2000, &mint_cap);

		make_limit_long(buyer1, 99, 5, true);
		make_limit_long(buyer2, 98, 2, true);
		make_limit_long(buyer3, 98, 8, false);
		make_limit_short(seller1, 100, 2, false);
		make_limit_short(seller2, 101, 5, true);

		make_market_short(seller3, 2000);

		let bal = aptos_framework::coin::balance<AptosCoin>(signer::address_of(seller3));
		assert!(bal == 618, 0u64);

		let (_, _, _, state) = fetch_order_details(buyer1, 0);
		assert!(state == constants::Filled(), 2);

		let (_, _, _, state) = fetch_order_details(buyer2, 0);
		assert!(state == constants::Filled(), 3);

		let (_, _, _, state) = fetch_order_details(buyer3, 0);
		assert!(state == constants::Active(), 1);

		let (_, _, _, state) = fetch_order_details(seller1, 0);
		assert!(state == constants::Active(), 4);

		close_order<AptosCoin, BTC>(seller3, 6);

		let bal = aptos_framework::coin::balance<AptosCoin>(signer::address_of(seller3));
		assert!(bal == 1986, 6);

		aptos_framework::coin::destroy_mint_cap(mint_cap);
	}


	#[test(admin = @resource_account)]
	fun test_order_expiry(admin: signer) acquires ContractStorage, UserResource , Market{
		setup(&admin);
		let mint_cap = initialize_aptos_coin();

		let seller1 = &create_user_with_address(@0xF001);
		let buyer1 = &create_user_with_address(@0xF002);

		mint_and_deposit(signer::address_of(buyer1), 2000, &mint_cap);
		mint_and_deposit(signer::address_of(seller1), 2000, &mint_cap);

		make_limit_long(buyer1, 99, 5, false);
		make_limit_short(seller1, 99, 6, true);

		assert!(balance(signer::address_of(buyer1)) == 2000-247, 0);
		assert!(balance(signer::address_of(seller1)) == 2000-1188, 0);
		assert!(balance(@resource_account) == 247+1188, 0);


		timestamp::update_global_time_for_test(timestamp::now_microseconds() + 3*ONE_DAY_MS);

		assert!(order::is_expired(1), 0);
		assert!(order::is_expired(2), 1);

		make_limit_long(buyer1, 99, 5, true);
		assert!(balance(signer::address_of(buyer1)) == 2000-247-247, 3);
		let (_, _, _, state) = fetch_order_details(buyer1, 1);
		assert!(state == constants::Active(), 4);

		make_limit_short(seller1, 99, 4, true);
		assert!(balance(signer::address_of(seller1)) == 2000-792-1188, 3);
		let (_, _, _, state) = fetch_order_details(seller1, 1);
		assert!(state == constants::Filled(), 4);

		close_order<AptosCoin, BTC>(buyer1, 1);
		assert!(aptos_framework::coin::balance<AptosCoin>(signer::address_of(buyer1)) == 2000-247, 2);
		close_order<AptosCoin, BTC>(seller1, 2);
		assert!(aptos_framework::coin::balance<AptosCoin>(signer::address_of(seller1)) == 2000-792, 2);

		let new_expiration = borrow_global<ContractStorage>(@resource_account).global_expiration_time;
		assert!(new_expiration != order::expiry(1), 5);
		assert!(new_expiration != order::expiry(1), 6);
		assert!(new_expiration == order::expiry(3), 7);

		aptos_framework::coin::destroy_mint_cap(mint_cap);
	}
}
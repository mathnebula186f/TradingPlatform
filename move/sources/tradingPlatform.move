/**
* Module that will hold all the platform APIs
*/
module ContractAddr::TradingPlatform {
	use std::signer;
	use std::vector;
	use ContractAddr::Order;
	use ContractAddr::OrderHeap::{Self, OrderHeap};
	use aptos_framework::table::{Self, Table};

	const E_NOT_REGISTERED: u64 = 5;

	struct ContractStorage has key {
		sellOrders : OrderHeap,					//	Only active sell orders
		buyOrders : OrderHeap,					//	Only active buy orders
		orderTable: Table<u64, Order::Order>	//	All orders including cancelled
	}

	struct UserResource has key, drop {	
		activeOrders: vector<u64>
	}

	entry fun init_module(sender: &signer) {
		move_to(sender,  ContractStorage {
			sellOrders: OrderHeap::MinHeap(),
			buyOrders: OrderHeap::MaxHeap(),
			orderTable: table::new<u64, Order::Order>()
		});
	}

	/**
	*	Register a new user by
	*	creating a resource under
	*	his address
	*/
	entry fun register(sender: &signer) {
		let user_resource = UserResource {
			activeOrders: vector::empty<u64>()
		};

		move_to(sender, user_resource);
	}

	fun check_registration(user: &signer) {
		let registered: bool = exists<UserResource>(signer::address_of(user));
		assert!(registered, E_NOT_REGISTERED);
	}

	/**
	*	Add a new sell request
	*	for the seller
	*/
	entry fun sell_request(seller: &signer, price: u64, units: u64) acquires ContractStorage, UserResource {
		check_registration(seller);

	//	Get a new order
		let (order, id) = Order::generateOrder(
			price,
			units,
			Order::Sell(),
			signer::address_of(seller),
		);

		/**
		*		TODO
		*
		*	Highest Buy price ?? 
		*  if (highestBuyPrice < sellPrice) {
		*		addToActiveOrderHeap;
		* 	} else {
		*		DoTransaction;
		* 		RemoveBuyOrderFromActive;
		* 		AddToFulfilledOrders;
		*	}
		*/

	//	Add the orderId to the user list
		let userStore = borrow_global_mut<UserResource>(signer::address_of(seller));
		vector::push_back(&mut userStore.activeOrders, id);

	//	Add the order to active sellOrders heap as well as the permanent orderTable
		let contractStore = borrow_global_mut<ContractStorage>(@ContractAddr);
		table::add(&mut contractStore.orderTable, id, copy order);
		OrderHeap::insert(&mut contractStore.sellOrders, copy order);
	}

	/**
	*	Add a new buy request
	*	for the buyer
	*/
	entry fun buy_request(buyer: &signer, price: u64, units: u64) acquires ContractStorage, UserResource {
		check_registration(buyer);

	//	Get a new order
		let (order, id) = Order::generateOrder(
			price,
			units,
			Order::Buy(),
			signer::address_of(buyer),
		);

		/**
		*		TODO
		*
		*	Highest Buy price ?? 
		*  if (lowestSellPrice > buyPrice) {
		*		addToActiveOrderHeap;
		* 	} else {
		*		DoTransaction;
		* 		RemoveSellOrderFromActive;
		* 		AddToFulfilledOrders;
		*	}
		*/

	//	Add the orderId to the user list
		let userStore = borrow_global_mut<UserResource>(signer::address_of(buyer));
		vector::push_back(&mut userStore.activeOrders, id);

	//	Add the order to active buyOrders heap as well as the permanent orderTable
		let contractStore = borrow_global_mut<ContractStorage>(@ContractAddr);
		table::add(&mut contractStore.orderTable, id, copy order);
		OrderHeap::insert(&mut contractStore.buyOrders, copy order);
	}

	/**
	*	Cancel a previuously made
	*	request by the user
	*/
	entry fun cancel_request(user: &signer, order_id: u64) acquires ContractStorage, UserResource {
		check_registration(user);
	//	Grab all mutable references
		let storage = borrow_global_mut<ContractStorage>(@ContractAddr);
		let userStore = borrow_global_mut<UserResource>(signer::address_of(user));

	//	Grab and remove the order_id from user's activeOrders list
		let (present, idx) = vector::index_of(&userStore.activeOrders, &order_id);
		assert!(present, 0u64);
		vector::swap_remove(&mut userStore.activeOrders, idx);
		
	//	Grab the order from Contract's OrderTable
		let order = table::borrow_mut(&mut storage.orderTable, order_id);
		assert!(Order::state(order) == Order::Active(), 1u64);

	//	Remove order from Contract's ActiveOrders heap
		let heap = if (Order::type(order) == Order::Buy()) &mut storage.buyOrders else &mut storage.sellOrders ;
		OrderHeap::remove(heap, order);

	//	Change Order's state to cancelled
		Order::set_state(order, Order::Cancelled());
	}

	#[test_only]
	fun initialize_all(user: &signer) {
		init_module(user);
		Order::initialize(user);
	}

	#[test_only]
	fun initialize_and_register(user: &signer) {
		initialize_all(user);
		register(user);
	}

	#[test(user = @ContractAddr)]
	fun test_registration_working(user: signer) {
		register(&user);
		check_registration(&user);
	}

	#[test(user = @ContractAddr), expected_failure(abort_code = E_NOT_REGISTERED)]
	fun test_unregistered_user_cant_use(user: signer) {
		check_registration(&user);
	}

	#[test(user = @ContractAddr)]
	fun test_sell_request_working(user: signer) acquires ContractStorage, UserResource {
		initialize_and_register(&user);

		let cnt = 0;
		sell_request(&user, 100, 2);	cnt = cnt + 1;
		sell_request(&user, 10, 1);	cnt = cnt + 1;
		sell_request(&user, 1000, 1);	cnt = cnt + 1;
	
		let userResource = borrow_global<UserResource>(signer::address_of(&user));
		assert!(vector::length(&userResource.activeOrders) == cnt, 0u64);
		move userResource;

		cancel_request(&user, 1);				cnt = cnt - 1;

		let userResource = borrow_global<UserResource>(signer::address_of(&user));
		assert!(vector::length(&userResource.activeOrders) == cnt, 1u64);

		let store = borrow_global<ContractStorage>(signer::address_of(&user));
		let lowestSell = OrderHeap::head(&store.sellOrders);
		assert!(Order::price(lowestSell) == 100u64, 2u64);
	}

	#[test(user = @ContractAddr)]
	fun test_buy_request_working(user: signer) acquires ContractStorage, UserResource {
		initialize_and_register(&user);

		let cnt = 0;
		buy_request(&user, 100, 2);	cnt = cnt + 1;
		buy_request(&user, 10, 1);	cnt = cnt + 1;
		buy_request(&user, 1000, 1);	cnt = cnt + 1;
	
		let userResource = borrow_global<UserResource>(signer::address_of(&user));
		assert!(vector::length(&userResource.activeOrders) == cnt, 0u64);
		move userResource;

		cancel_request(&user, 2);				cnt = cnt - 1;

		let userResource = borrow_global<UserResource>(signer::address_of(&user));
		assert!(vector::length(&userResource.activeOrders) == cnt, 1u64);

		let store = borrow_global<ContractStorage>(signer::address_of(&user));
		let largestBuy = OrderHeap::head(&store.buyOrders);
		assert!(Order::price(largestBuy) == 100u64, 2u64);
	}

	#[test(user = @ContractAddr), expected_failure]
	fun test_cancel_order_does_not_exist(user: signer) acquires ContractStorage, UserResource {
		initialize_and_register(&user);

		cancel_request(&user, 0);
	}

}

/**
* Module for handling generation of Orders
*/
module ContractAddr::Order {
	friend ContractAddr::TradingPlatform;
	#[test_only]
	friend ContractAddr::OrderHeap;

	use aptos_framework::timestamp;

	const BUY: u8 = 0u8;
	const SELL: u8 = 1u8;

	const ACTIVE: u8 = 0u8;
	const FULFILLED: u8 = 1u8;
	const CANCELLED: u8 = 2u8;

	public fun Buy(): u8 {
		BUY
	}

	public fun Sell(): u8 {
		SELL
	}

	public fun Active(): u8 {
		ACTIVE
	}

	public fun Fulfilled(): u8 {
		FULFILLED
	}

	public fun Cancelled(): u8 {
		CANCELLED
	}

	struct Order has store, drop, copy {
		price: u64,
		units: u64,
		bidder: address,
		timestamp: u64,
		type: u8,
		state: u8
	}

	struct Storage has key, drop {
		id: u64
	}

	/**
	*	Initialize the module
	*/
	entry fun init_module(owner: &signer) {
		move_to(owner, Storage {
			id: 0u64
		});
	}

	/**
	*	Create an instance of Order::Order
	*/
	public(friend) fun generateOrder(
		price: u64,
		units: u64,
		type: u8,
		bidder: address,
	) : (Order, u64) acquires Storage {
		let storage = borrow_global_mut<Storage>(@ContractAddr);
		let id = storage.id;
		storage.id = id + 1;
		(Order {
			price,
			units,
			bidder,
			timestamp: timestamp::now_microseconds(),
			type, 
			state: ACTIVE
		}, id)
	}

	/**
	*	Getters and setters for
	*	the Order::Order type
	*/

	public fun set_state(order: &mut Order, state: u8) {
		assert!(state <= CANCELLED, 0u64);
		order.state = state;
	}

	public fun price(order: &Order) : (u64) {
		order.price
	}

	public fun units(order: &Order) : (u64) {
		order.units
	}

	public fun state(order: &Order) : (u8) {
		order.state
	}

	public fun type(order: &Order): (u8) {
		order.type
	}

	public fun time(order: &Order): (u64) {
		order.timestamp
	}

	#[test_only]
	public(friend) fun initialize(user: &signer) {
		init_module(user);
	}
}

/**
* Module with functions for 
* Heap of Orders
*/
module ContractAddr::OrderHeap {
	use std::vector;
	use ContractAddr::Order::{Self, Order};

	const MAX_HEAP: u8 = 0;
	const MIN_HEAP: u8 = 1;

	struct OrderHeap has store, drop {
		arr: vector<Order>,
		type: u8
	}

	public fun MaxHeap() : (OrderHeap) {
		OrderHeap {
			arr: vector::empty<Order>(),
			type: MAX_HEAP
		}
	}

	public fun MinHeap() : (OrderHeap) {
		OrderHeap {
			arr: vector::empty<Order>(),
			type: MIN_HEAP,
		}
	}

	/**
	*	Insert a new Order
	*/
	public fun insert(heap: &mut OrderHeap, order: Order) {
		assert!(((heap.type == MAX_HEAP) || (heap.type == MIN_HEAP)), 0u64);
		vector::push_back(&mut heap.arr, order);
		let child = vector::length(&heap.arr)-1;

		loop {
			if (child == 0)	break;

			let parent = (child-1)/2;
			let parentVal = vector::borrow(&heap.arr, parent);
			let childVal = vector::borrow(&heap.arr, child);

			if (heap.type == MIN_HEAP && Order::price(childVal) < Order::price(parentVal)) {
				vector::swap(&mut heap.arr, parent, child);
				child = parent;
			} else if (heap.type == MAX_HEAP && Order::price(childVal) > Order::price(parentVal)) {
				vector::swap(&mut heap.arr, parent, child);
				child = parent;
			} else	break;
		};
	}

	public fun match(heap: &mut OrderHeap, order: &Order) : (u64, vector<Order>) {
		assert!(1-Order::type(order) == heap.type, 0u64);

		let matched = vector::empty<Order>();
		let offerPrice = Order::price(order);
		let requiredUnits = Order::units(order);
		let matchedUnits = 0u64;

		loop {
			if (matchedUnits >= requiredUnits)	break;

			let head = *head(heap);
			let bestPrice = Order::price(&head);

			if (heap.type == MIN_HEAP && bestPrice <= offerPrice) {
				matchedUnits = matchedUnits + Order::units(&head);
				vector::push_back(&mut matched, head);
				pop(heap);
			} else if (heap.type == MAX_HEAP && bestPrice >= offerPrice) {
				matchedUnits = matchedUnits + Order::units(&head);
				vector::push_back(&mut matched, head);
				pop(heap);
			} else break;
		};

		(matchedUnits, matched)
	}

	/**
	*	Return the order on top
	*/
	public fun head(heap: &OrderHeap): (&Order) {
		vector::borrow(&heap.arr, 0)
	}

	public fun remove(heap: &mut OrderHeap, order: &Order) {
		let (found, idx) = vector::index_of(&heap.arr, order);
		if (found) {
			vector::swap_remove(&mut heap.arr, idx);
			heapify(heap, idx);
		}
	}

	fun heapify(heap: &mut OrderHeap, root: u64) {
		let parent = root;
		let len = vector::length(&heap.arr);
		loop {
			let left = 2*parent + 1;
			let right = 2*parent + 2;
			let best = parent;

			if (left < len) {
				let leftVal = vector::borrow(&heap.arr, left);
				let bestVal = vector::borrow(&heap.arr, best);
				if (heap.type == MIN_HEAP && Order::price(leftVal) < Order::price(bestVal)) {
					best = left;
				} else if (heap.type == MAX_HEAP && Order::price(leftVal) > Order::price(bestVal)) {
					best = left;
				}
			};

			if (right < len) {
				let rightVal = vector::borrow(&heap.arr, right);
				let bestVal = vector::borrow(&heap.arr, best);
				if (heap.type == MIN_HEAP && Order::price(rightVal) < Order::price(bestVal)) {
					best = right;
				} else if (heap.type == MAX_HEAP && Order::price(rightVal) > Order::price(bestVal)) {
					best = right;
				}
			};

			if(best != parent) {
				vector::swap(&mut heap.arr, best, parent);
				parent = best;
			} else break;
		}
	}

	/**
	*	Remove the Order with highest or lowest price
	*	according to min/max heap property
	*/
	public fun pop(heap: &mut OrderHeap) {
		vector::swap_remove(&mut heap.arr, 0);
		let root = 0u64;

		heapify(heap, root);
		// debug::print(heap);
	}

	#[test(user = @ContractAddr)]
	fun test_double_add(user: signer) {
		Order::initialize(&user);

		let minHeap = MinHeap();
		let maxHeap = MaxHeap();
		let err = 0u64;

		let (orderBig, _) = Order::generateOrder(
			100u64,
			1u64,
			Order::Sell(),
			@ContractAddr,
		);
		let (orderSmall, _) = Order::generateOrder(
			10u64,
			1u64,
			Order::Sell(),
			@ContractAddr,
		);

		insert(&mut minHeap, copy orderBig);
		insert(&mut minHeap, copy orderSmall);

		let h = head(&minHeap);
		assert!(Order::price(h) == 10u64, err);
		err = err + 1;
		pop(&mut minHeap);

		let h = head(&minHeap);
		assert!(Order::price(h) == 100u64, err);
		err = err + 1;
		pop(&mut minHeap);

		insert(&mut maxHeap, orderBig);
		insert(&mut maxHeap, orderSmall);

		let h = head(&maxHeap);
		assert!(Order::price(h) == 100u64, err);
		err = err + 1;
		pop(&mut maxHeap);

		let h = head(&maxHeap);
		assert!(Order::price(h) == 10u64, err);
		pop(&mut maxHeap);
	}

	#[test(user = @ContractAddr)]
	fun test_match_function_when_possible(user: signer) {
		Order::initialize(&user);

		let minHeap = MinHeap();

		let (order, _) = Order::generateOrder(10, 5, Order::Sell(), @ContractAddr);
		insert(&mut minHeap, order);
		let (order, _) = Order::generateOrder(11, 5, Order::Sell(), @ContractAddr);
		insert(&mut minHeap, order);
		let (order, _) = Order::generateOrder(13, 5, Order::Sell(), @ContractAddr);
		insert(&mut minHeap, order);
		let (order, _) = Order::generateOrder(15, 5, Order::Sell(), @ContractAddr);
		insert(&mut minHeap, order);

		let (order, _) = Order::generateOrder(12, 6, Order::Buy(), @ContractAddr);
		let (units, orders) = match(&mut minHeap, &order);

		assert!(units == 10u64, 0u64);
		assert!(vector::length(&orders) == 2u64, 1u64);
		
		let firstMatch = vector::borrow(&orders, 0);
		assert!(Order::price(firstMatch) == 10u64, 2u64);
		assert!(Order::units(firstMatch) == 5u64, 3u64);

		let secondMatch = vector::borrow(&orders, 1);
		assert!(Order::price(secondMatch) == 11u64, 4u64);
		assert!(Order::units(secondMatch) == 5u64, 5u64);
	}
}

module ContractAddr::DummyCoin {
	use aptos_framework::managed_coin;

	struct DummyCoin {}

	entry fun init_module(admin: &signer) {
		managed_coin::initialize<DummyCoin>(admin, b"DummyCoin", b"DCOIN", 8, true);
	}

	public entry fun mint(admin: &signer, destination: address) {
		managed_coin::mint<DummyCoin>(admin, destination, 10);
	}
}
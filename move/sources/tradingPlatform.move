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

	const ORDER_ACTIVE: u8 = 0;
	const ORDER_FULFILLED: u8 = 1;
	const ORDER_CANCELLED: u8 = 2;

	struct ContractStorage has key {
		sellOrders : OrderHeap,					//	Only active sell orders
		buyOrders : OrderHeap,					//	Only active buy orders
		orderTable: Table<u64, Order::Order>	//	All orders including cancelled
	}

	struct UserResource has key {	
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
		let order = Order::generateOrder(
			price,
			units,
			signer::address_of(seller),
			ORDER_ACTIVE
		);

		// Add the orderId to the user list
		let userStore = borrow_global_mut<UserResource>(signer::address_of(seller));
		vector::push_back(&mut userStore.activeOrders, Order::id(&order));

		// Add the order to active sellOrders heap as well as the permanent orderTable
		let contractStore = borrow_global_mut<ContractStorage>(@ContractAddr);
		table::add(&mut contractStore.orderTable, Order::id(&order), copy order);
		OrderHeap::insert(&mut contractStore.sellOrders, copy order);
	}

	#[test(user = @ContractAddr)]
	fun test_register(user: signer) {
		register(&user);
		check_registration(&user);
	}

	#[test(user = @ContractAddr), expected_failure(abort_code = 5)]
	fun test_unregistered_use(user: signer) {
		check_registration(&user);
	}

	#[test(user = @ContractAddr)]
	fun test_sell_request_working(user: signer) acquires ContractStorage, UserResource {
		init_module(&user);
		Order::initialize(&user);
		register(&user);

		let cnt = 0;
		sell_request(&user, 100, 2);	cnt = cnt + 1;
		sell_request(&user, 10, 1);	cnt = cnt + 1;
	
		let userResource = borrow_global<UserResource>(signer::address_of(&user));
		assert!(vector::length(&userResource.activeOrders) == cnt, 0u64);

		let store = borrow_global<ContractStorage>(signer::address_of(&user));
		let lowestSell = OrderHeap::head(&store.sellOrders);
		assert!(Order::price(lowestSell) == 10u64, 1u64);

		assert!(Order::price(table::borrow(&store.orderTable, *vector::borrow(&userResource.activeOrders, 0))) == 100u64, 2u64);
	}
}

/**
* Module for handling generation of Orders
*/
module ContractAddr::Order {
	friend ContractAddr::TradingPlatform;
	#[test_only]
	friend ContractAddr::OrderHeap;

	struct Order has store, drop, copy {
		id: u64,
		price: u64,
		units: u64,
		bidder: address,
		state: u8
	}

	struct Storage has key {
		id: u64
	}

	entry fun init_module(owner: &signer) {
		move_to(owner, Storage {
			id: 0u64
		});
	}

	public(friend) fun generateOrder(
		price: u64,
		units: u64,
		bidder: address,
		state: u8
	) : (Order) acquires Storage {
		let storage = borrow_global_mut<Storage>(@ContractAddr);
		let id = storage.id;
		storage.id = id + 1;
		Order {
			id,
			price,
			units,
			bidder,
			state
		}
	}

	public fun price(order: &Order) : (u64) {
		order.price
	}

	public fun units(order: &Order) : (u64) {
		order.units
	}

	public fun id(order: &Order) : (u64) {
		order.id
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

	const MIN_HEAP: u8 = 0;
	const MAX_HEAP: u8 = 1;

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

	/**
	*	Return the order on top
	*/
	public fun head(heap: &OrderHeap): (&Order) {
		vector::borrow(&heap.arr, 0)
	}

	/**
	*	Remove the Order with highest or lowest price
	*	according to min/max heap property
	*/
	public fun pop(heap: &mut OrderHeap) {
		vector::swap_remove(&mut heap.arr, 0);
		let parent = 0u64;
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
				if (heap.type == MAX_HEAP && Order::price(rightVal) < Order::price(bestVal)) {
					best = right;
				} else if (heap.type == MIN_HEAP && Order::price(rightVal) > Order::price(bestVal)) {
					best = right;
				}
			};

			if(best != parent) {
				vector::swap(&mut heap.arr, best, parent);
				parent = best;
			} else break;
		}
	}

	#[test(user = @ContractAddr)]
	fun test_double_add(user: signer) {
		Order::initialize(&user);

		let minHeap = MinHeap();
		let maxHeap = MaxHeap();
		let err = 0u64;

		let orderBig = Order::generateOrder(
			100u64,
			1u64,
			@ContractAddr,
			0u8
		);
		let orderSmall = Order::generateOrder(
			10u64,
			1u64,
			@ContractAddr,
			0u8
		);

		insert(&mut minHeap, orderBig);
		insert(&mut minHeap, orderSmall);

		let h = head(&minHeap);
		assert!(Order::price(h) == 10u64, err);
		err = err + 1;
		pop(&mut minHeap);

		let h = head(&minHeap);
		assert!(Order::price(h) == 100u64, err);
		err = err + 1;
		pop(&mut minHeap);


		let orderBig = Order::generateOrder(
			100u64,
			1u64,
			@ContractAddr,
			0u8
		);
		let orderSmall = Order::generateOrder(
			10u64,
			1u64,
			@ContractAddr,
			0u8
		);

		insert(&mut maxHeap, orderSmall);
		insert(&mut maxHeap, orderBig);

		let h = head(&maxHeap);
		assert!(Order::price(h) == 100u64, err);
		err = err + 1;
		pop(&mut maxHeap);

		let h = head(&maxHeap);
		assert!(Order::price(h) == 10u64, err);
		pop(&mut maxHeap);
	}
}
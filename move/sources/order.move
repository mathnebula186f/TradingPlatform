/**
* Module containing functions surrounding Orders
*/
module resource_account::order {
	use std::vector;
	use resource_account::constants;
	use aptos_framework::table::{Self, Table};
	use aptos_framework::timestamp;

	friend resource_account::trading_platform;

	const MAX_HEAP: u8 = 0;
	const MIN_HEAP: u8 = 1;

	/**
	* Encapsulate data surrounding an Order
	*/
	struct Order has store {
		id: u64,
		type: u8,
		position: u8,

		price: u64,
		target_units: u64,
		remaining_units: u64,
		margin_deposits: u64,

		positions: vector<u64>,

		of: address,
		timestamp: u64,
		expiration_time: u64,

		flexible: bool,

		state: u8,
	}

	/**
	* Store a heap of references to orders, primarily sorted by prices and then further with timestamp
	*/
	struct OrderHeap has store, drop {
		arr: vector<PriceLevel>,
		type: u8
	}

	/**
	* Pricelevel stores all the orders at a given pricelevel
	*	- fixedOrders are orders that have to consumed atomically
	*	- flexibleOrders are orders that can be consumed in parts
	*/
	struct PriceLevel has store, drop {
		price: u64,
		fixedOrders: vector<u64>,
		flexibleOrders: vector<u64>,
	}
	
	/**
	* Storage of all the orders ever generated
	*/
	struct OrderStore has key {
		orders: Table<u64, Order>,
		id: u64,
	}

	/**
	* Create a max heap
	*/
	public fun MaxHeap() : (OrderHeap) {
		OrderHeap {
			arr: vector::empty<PriceLevel>(),
			type: MAX_HEAP
		}
	}

	/**
	* Create a min heap
	*/
	public fun MinHeap() : (OrderHeap) {
		OrderHeap {
			arr: vector::empty<PriceLevel>(),
			type: MIN_HEAP,
		}
	}

	/// Initialize global order storage and id generator
	entry fun init_module(admin: &signer) {
		let order_table = table::new<u64, Order>();
		table::add(&mut order_table, 0, Order {
			id: 0,
			type: 0,
			position: 0,

			price: 0,
			target_units: 0,
			remaining_units: 0,
			margin_deposits: 0,

			positions: vector::empty<u64>(),

			of: @0x0,
			timestamp: 0,
			expiration_time: 0,
			
			flexible: false,
			
			state: 0,
		});
		move_to(admin, OrderStore {
			orders: order_table,
			id: 1,
		});
	}

	/**
	* Insert a order to the heap
	*/
	public fun heap_insert(heap: &mut OrderHeap, id: u64) acquires OrderStore {
		let order = fetch_order_ref(id);
		let price_level = PriceLevel {
			price: order.price,
			fixedOrders: vector::empty<u64>(),
			flexibleOrders: vector::empty<u64>(),
		};

		if (order.flexible) vector::push_back(&mut price_level.flexibleOrders, id) else vector::push_back(&mut price_level.fixedOrders, id) ;

		if (vector::length(&heap.arr) == 0) {
			vector::push_back(&mut heap.arr, price_level);
			return
		};

		let cur = vector::length(&heap.arr)-1;
		loop {
			let cur_ref = vector::borrow_mut(&mut heap.arr, cur);

			if (heap.type == MIN_HEAP && price_level.price < cur_ref.price) {
				if (cur == 0){
					insert_assuming_no_repeat(heap, price_level);
					break
				};
				cur = parent(cur);
			} else if (heap.type == MAX_HEAP && price_level.price > cur_ref.price) {
				if (cur == 0) {
					insert_assuming_no_repeat(heap, price_level);
					break
				};
				cur = parent(cur);
			} else if(price_level.price == cur_ref.price) {
				let vec = if(order.flexible) 
					&mut cur_ref.flexibleOrders 
				else 
					&mut cur_ref.fixedOrders
				;
				add_to_timestamp_heap(vec, order.id);
				break
			} else {
				insert_assuming_no_repeat(heap, price_level);
				break
			}
		};
	}

	/**
	* Try to pair `units` units with a price cap (lower cap if max heap and upper cap if min heap)
	*/
	public fun heap_match(heap: &mut OrderHeap, id: u64) : (u64, vector<u64>) acquires OrderStore {
		let order = fetch_order_ref(id);

		let matched = vector::empty<u64>();
		let matchedUnits = 0u64;
		let requiredUnits = order.remaining_units;
		let targetPrice = order.price;

		let residue = vector<u64>[];
		while (matchedUnits < requiredUnits && !heap_is_empty(heap)) {
			let head = head_pricelevel_mut(heap);

			if (heap.type == MIN_HEAP && head.price > targetPrice)	break;
			if (heap.type == MAX_HEAP && head.price < targetPrice)	break;

			while (matchedUnits < requiredUnits) {
				let storage = borrow_global<OrderStore>(@resource_account);
				let top_fixed_order = best_fixed_order(head, storage);
				let top_flex_order = best_flex_order(head, storage);
				let next_candidate = best_order(top_fixed_order, top_flex_order);
				
				if (! is_valid(next_candidate)) {
					pop_pricelevel(heap);
					break
				};

				let fixed = (top_fixed_order == next_candidate);

				if (next_candidate.state != constants::Cancelled() && next_candidate.expiration_time > timestamp::now_microseconds()) {
					if ((matchedUnits + next_candidate.remaining_units > requiredUnits) && fixed) {
						vector::push_back(&mut residue, next_candidate.id);
					} else {
						matchedUnits = matchedUnits + next_candidate.remaining_units;
						vector::push_back(&mut matched, next_candidate.id);
					};
				};

				let vec = if (fixed) 
					&mut head.fixedOrders 
				else
					&mut head.flexibleOrders
				;
				pop_from_timestamp_heap(vec);
			};

			if (matchedUnits >= requiredUnits) break;
		};

		vector::for_each(residue, |order| {
			heap_insert(heap, order);
		});

		(matchedUnits, matched)
	}

	/**
	* Return the order on top of the heap
	*/
	public fun heap_head(heap: &OrderHeap): u64 acquires OrderStore {
		let storage = borrow_global<OrderStore>(@resource_account);

		let top = vector::borrow(& heap.arr, 0);

		let top_fixed_order = best_fixed_order(top, storage);
		let top_flex_order = best_flex_order(top, storage);

		let top_order = best_order(top_fixed_order, top_flex_order) ;

		top_order.id
	}

	/**
	* Remove and return the order on top of the heap
	*/
	public fun heap_pop(heap: &mut OrderHeap): u64 acquires OrderStore {
		let storage = borrow_global<OrderStore>(@resource_account);

		let top = vector::borrow_mut(&mut heap.arr, 0);
	
		let top_fixed_order = best_fixed_order(top, storage);
		let top_flex_order = best_flex_order(top, storage);


		let top_order = best_order(top_fixed_order, top_flex_order) ;
		let fixed = (top_order == top_fixed_order);
		let top_id = top_order.id;

		move top_order;
		move storage;

		if (fixed) {
			pop_from_timestamp_heap(&mut top.fixedOrders);
		} else {
			pop_from_timestamp_heap(&mut top.flexibleOrders);
		};

		let new_head = fetch_order_ref(heap_head(heap));
		if (! is_valid(new_head)) {
			pop_pricelevel(heap);
		};

		top_id
	}

	public fun heap_is_empty(heap: & OrderHeap): bool {
		vector::length(& heap.arr) == 0
	}

	fun add_to_timestamp_heap(vec: &mut vector<u64>, order: u64) acquires OrderStore {
		vector::push_back(vec, order);

		let cur = vector::length(vec)-1;
		loop {

			if (cur == 0)	break;

			let p = parent(cur);
			let parent_order = *vector::borrow(vec, p);
			let cur_order = *vector::borrow(vec, cur);

			if (time(parent_order) > time(cur_order)) {
				vector::swap(vec, p, cur);
				cur = p;
			} else break;
		};
	}

	fun pop_from_timestamp_heap(vec: &mut vector<u64>) acquires OrderStore {
		vector::swap_remove(vec, 0);

		let parent = 0u64;
		let len = vector::length(vec);

		if (len == 0) return ;

		loop {
			let left_child = 2*parent + 1;
			let right_child = 2*parent + 2;
			let parent_order = *vector::borrow(vec, parent);
			let oldest = parent;

			if (left_child < len) {
				let left = *vector::borrow(vec, left_child);
				if (time(left) < time(parent_order)) {
					oldest = left_child;
				}
			};

			if (right_child < len) {
				let right = *vector::borrow(vec, right_child);
				if (time(right) < time(parent_order)) {
					oldest = right_child;
				}
			};

			if (oldest != parent) {
				vector::swap(vec, parent, oldest);
				parent = oldest;
			} else break;

		}
	}

	fun insert_assuming_no_repeat(heap: &mut OrderHeap, price_level: PriceLevel) {
		vector::push_back(&mut heap.arr, price_level);

		let cur = vector::length(& heap.arr)-1;
		loop {

			if (cur == 0)	break;

			let parent_ref = vector::borrow(&heap.arr, parent(cur));
			let price_level = vector::borrow(&heap.arr, cur);

			if (heap.type == MIN_HEAP && price_level.price < parent_ref.price) {
				vector::swap(&mut heap.arr,cur, parent(cur));
				cur = parent(cur);
			} else if (heap.type == MAX_HEAP && price_level.price > parent_ref.price) {
				vector::swap(&mut heap.arr, cur, parent(cur));
				cur = parent(cur);
			} else break;
		}
	}

	inline fun head_pricelevel(heap: &OrderHeap): &PriceLevel {
		vector::borrow(&heap.arr, 0)
	}

	inline fun head_pricelevel_mut(heap: &mut OrderHeap): &mut PriceLevel {
		vector::borrow_mut(&mut heap.arr, 0)
	}

	inline fun parent(idx: u64): u64 { 
		(idx - 1)/2
	}

	fun best_fixed_order(price_level: &PriceLevel, storage: &OrderStore): &Order {
		let vec = &price_level.fixedOrders;
		let key = if (vector::length(vec) == 0) 0u64 else *vector::borrow(vec, 0) ;
		table::borrow(
			&storage.orders,
			key,
		)
	}

	fun best_flex_order(price_level: &PriceLevel, storage: &OrderStore): &Order {
		let vec = &price_level.flexibleOrders;
		let key = if (vector::length(vec) == 0) 0u64 else *vector::borrow(vec, 0) ;
		table::borrow(
			&storage.orders,
			key,
		)
	}

	inline fun best_order(top_fixed_order: &Order, top_flex_order: &Order): &Order {
		if (is_valid(top_fixed_order) && is_valid(top_flex_order)) {
			if (top_fixed_order.timestamp > top_flex_order.timestamp)
				top_flex_order
			else
				top_fixed_order
		} else {
			if (is_valid(top_fixed_order))
				top_fixed_order
			else
				top_flex_order
		}
	}

	inline fun is_valid(order_ref: &Order): bool {
		(order_ref.timestamp != 0)
	}

	fun heapify(heap: &mut OrderHeap, root: u64) acquires OrderStore {
		let parent = root;
		let len = vector::length(&heap.arr);
		loop {
			let left = 2*parent + 1;
			let right = 2*parent + 2;
			let best = parent;

			if (left < len) {
				let leftVal = vector::borrow(&heap.arr, left);
				let bestVal = vector::borrow(&heap.arr, best);
				if (heap.type == MIN_HEAP && leftVal.price < bestVal.price) {
					best = left;
				} else if (heap.type == MAX_HEAP && leftVal.price > bestVal.price) {
					best = left;
				} else if (best == parent && leftVal.price == bestVal.price) {
					move leftVal;
					move bestVal;
					let left_pl = vector::swap_remove(&mut heap.arr, left);
					let bestVal = vector::borrow_mut(&mut heap.arr, best);
					merge_into_pricelevel(bestVal, &left_pl);
					heapify(heap, left);
				};
			};

			if (right < len) {
				let rightVal = vector::borrow(&heap.arr, right);
				let bestVal = vector::borrow(& heap.arr, best);
				if (heap.type == MIN_HEAP && rightVal.price < bestVal.price) {
					best = right;
				} else if (heap.type == MAX_HEAP && rightVal.price > bestVal.price) {
					best = right;
				} else if (best == parent && rightVal.price == bestVal.price) {
					move rightVal;
					move bestVal;
					let right_pl = vector::swap_remove(&mut heap.arr, left);
					let bestVal = vector::borrow_mut(&mut heap.arr, best);
					merge_into_pricelevel(bestVal, &right_pl);
					vector::swap_remove(&mut heap.arr, right);
					heapify(heap, right);
				}
			};

			if(best != parent) {
				vector::swap(&mut heap.arr, best, parent);
				parent = best;
			} else break;
		}
	}

	fun merge_into_pricelevel(base: &mut PriceLevel, addition: &PriceLevel) acquires OrderStore {
		vector::for_each_ref(&addition.fixedOrders, |id| {
			add_to_timestamp_heap(&mut base.fixedOrders, *id);
		});
		vector::for_each_ref(&addition.flexibleOrders, |id| {
			add_to_timestamp_heap(&mut base.flexibleOrders, *id);
		});
	}

	fun pop_pricelevel(heap: &mut OrderHeap): PriceLevel acquires OrderStore {
		let pricelevel = vector::swap_remove(&mut heap.arr, 0);
		let root = 0u64;

		heapify(heap, root);
		pricelevel
	}


	/**
	*	Getters and setters for
	*	the constants::Order type
	*/

	/// Create a new order and return its id
	public(friend) fun newOrder(
		price: u64,
		units: u64,
		of: address,
		type: u8,
		flexible: bool,
		state: u8,
		position: u8,
		expiration_time: u64,
	) : u64 acquires OrderStore {
		let storage = borrow_global_mut<OrderStore>(@resource_account);
		let id = storage.id;
		storage.id = id + 1;
		table::add(&mut storage.orders, id, Order {
			id,
			type,
			position,

			price,
			target_units: units,
			remaining_units: units,
			margin_deposits: 0,

			positions: vector::empty<u64>(),

			of,
			timestamp: aptos_framework::timestamp::now_microseconds(),
			expiration_time,

			flexible,

			state,
		});
		id
	}

	public(friend) fun set_state(order: u64, state: u8) acquires OrderStore {
		fetch_order_ref_mut(order).state = state;
	}

	public(friend) fun set_units(order: u64, units: u64) acquires OrderStore {
		fetch_order_ref_mut(order).remaining_units = units;
	}

	public(friend) fun set_fixed(order: u64) acquires OrderStore {
		fetch_order_ref_mut(order).flexible = false;
	}

	public(friend) fun add_position(order: u64, position: u64) acquires OrderStore {
		vector::push_back(&mut fetch_order_ref_mut(order).positions, position);
	}

	public(friend) fun deposit_margin(order: u64, amount: u64) acquires OrderStore {
		let ref = fetch_order_ref_mut(order);
		ref.margin_deposits = ref.margin_deposits + amount;
	}

	public fun of(order: u64): address acquires OrderStore {
		fetch_order_ref(order).of
	}

	public fun time(order: u64): (u64) acquires OrderStore {
		fetch_order_ref(order).timestamp
	}

	#[view]
	public fun list_positions(order: u64): vector<u64> acquires OrderStore {
		fetch_order_ref(order).positions
	}

	#[view]
	public fun price(order: u64) : (u64) acquires OrderStore {
		fetch_order_ref(order).price
	}

	#[view]
	public fun units(order: u64) : (u64) acquires OrderStore {
		fetch_order_ref(order).remaining_units
	}

	#[view]
	public fun state(order: u64) : (u8) acquires OrderStore {
		fetch_order_ref(order).state
	}

	#[view]
	public fun type(order: u64): (u8) acquires OrderStore {
		fetch_order_ref(order).type
	}
	
	#[view]
	public fun expiry(order: u64): u64 acquires OrderStore {
		fetch_order_ref(order).expiration_time
	}

	#[view]
	public fun margin_deposits(order: u64): u64 acquires OrderStore {
		fetch_order_ref(order).margin_deposits
	}

	#[view]
	public fun is_flexible(order: u64): bool acquires OrderStore {
		fetch_order_ref(order).flexible
	}

	#[view]
	public fun is_expired(order: u64): bool acquires OrderStore {
		fetch_order_ref(order).expiration_time <= timestamp::now_microseconds()
	}

	public fun is_long(order: u64): bool acquires OrderStore {
		fetch_order_ref(order).position  == constants::Long()
	}

	inline fun fetch_order_ref(order: u64): &Order acquires OrderStore {
		table::borrow(&borrow_global<OrderStore>(@resource_account).orders, order)
	}

	inline fun fetch_order_ref_mut(order: u64): &mut Order acquires OrderStore {
		table::borrow_mut(&mut borrow_global_mut<OrderStore>(@resource_account).orders, order)
	}

	#[test_only]
	public fun initialize_module(admin: &signer) {
		if (!aptos_framework::account::exists_at(@aptos_framework)) {
			let framework = aptos_framework::account::create_account_for_test(@aptos_framework);
			let vm = aptos_framework::account::create_account_for_test(@vm_reserved);
			timestamp::set_time_has_started_for_testing(&framework);
			timestamp::update_global_time(&vm, @publisher_addr, 1);
		};
		init_module(admin);
	}

	#[test(admin = @resource_account)]
	fun test_heap_different_prices(admin: signer) acquires OrderStore {
		initialize_module(&admin);

		let minHeap = MinHeap();
		let maxHeap = MaxHeap();
		let passed = 0u64;

		let prices = vector[10u64, 12u64, 11u64, 15u64];
		let units = vector[2u64, 5, 6, 3];
		let users = vector[@0x11, @0x12, @0x13, @0x14];
		let order_ids = vector<u64>[];
		let prices_ascending = vector[10u64, 11, 12, 15];
		let units_ascending = vector[2u64, 6, 5, 3];
		let prices_descending = vector[15u64, 12, 11, 10];
		let units_descending = vector[3u64, 5, 6, 2];


		while (!vector::is_empty(&prices)) {
			vector::push_back(&mut order_ids, newOrder(
				vector::pop_back(&mut prices),
				vector::pop_back(&mut units),
				vector::pop_back(&mut users),
				constants::Limit(),
				false,
				constants::Active(),
				constants::Short(),
				0xFEE,
			));
		};

		vector::for_each_reverse(order_ids, |id| {
			heap_insert(&mut minHeap, id);
			heap_insert(&mut maxHeap, id);
		});

		// std::debug::print(&minHeap);
		vector::zip(prices_ascending, units_ascending, |price, units| {
			let head_order = fetch_order_ref(heap_head(&minHeap));
			// std::debug::print(head_order);
			assert!(head_order.price == price, passed);
			passed = passed + 1;
			assert!(head_order.remaining_units == units, passed);
			passed = passed + 1;
			heap_pop(&mut minHeap);
		});

		vector::zip(prices_descending, units_descending, |price, units| {
			let head_order = fetch_order_ref(heap_head(&maxHeap));
			assert!(head_order.price == price, passed);
			passed = passed + 1;
			assert!(head_order.remaining_units == units, passed);
			passed = passed + 1;
			heap_pop(&mut maxHeap);
		});
	}

	#[test(admin = @resource_account)]
	fun test_heap_same_prices(admin: signer) acquires OrderStore {
		initialize_module(&admin);

		let minHeap = MinHeap();
		let maxHeap = MaxHeap();
		let passed = 0u64;

		let prices = vector[10u64, 12u64, 11u64, 11u64];
		let units = vector[2u64, 5, 6, 3];
		let users = vector[@0x11, @0x12, @0x13, @0x14];
		let order_ids = vector<u64>[];
		let prices_ascending = vector[10u64, 11, 11, 12];
		let prices_descending = vector[12u64, 11, 11, 10];


		while (!vector::is_empty(&prices)) {
			vector::push_back(&mut order_ids, newOrder(
				vector::pop_back(&mut prices),
				vector::pop_back(&mut units),
				vector::pop_back(&mut users),
				constants::Limit(),
				false,
				constants::Active(),
				constants::Short(),
				0xFEE,
			));
		};

		vector::for_each_reverse(order_ids, |id| {
			heap_insert(&mut minHeap, id);
			heap_insert(&mut maxHeap, id);
		});

		// std::debug::print(&minHeap);
		vector::for_each(prices_ascending, |price| {
			let head_order = fetch_order_ref(heap_head(&minHeap));
			// std::debug::print(head_order);
			assert!(head_order.price == price, passed);
			passed = passed + 1;
			heap_pop(&mut minHeap);
		});

		vector::for_each(prices_descending, |price| {
			let head_order = fetch_order_ref(heap_head(&maxHeap));
			assert!(head_order.price == price, passed);
			passed = passed + 1;
			heap_pop(&mut maxHeap);
		});
	}

	#[test(admin = @resource_account)]
	fun test_heap_different_types(admin: signer) acquires OrderStore {
		initialize_module(&admin);

		let minHeap = MinHeap();
		let maxHeap = MaxHeap();
		let passed = 0u64;

		let prices = vector[10u64, 12u64, 11u64, 11u64];
		let units = vector[2u64, 5, 6, 3];
		let users = vector[@0x11, @0x12, @0x13, @0x14];
		let flexibility = vector[true, false, false, true];
		let order_ids = vector<u64>[];
		let prices_ascending = vector[10u64, 11, 11, 12];
		let prices_descending = vector[12u64, 11, 11, 10];


		while (!vector::is_empty(&prices)) {
			vector::push_back(&mut order_ids, newOrder(
				vector::pop_back(&mut prices),
				vector::pop_back(&mut units),
				vector::pop_back(&mut users),
				constants::Limit(),
				vector::pop_back(&mut flexibility),
				constants::Active(),
				constants::Short(),
				0xFEE,
			));
		};

		vector::for_each_reverse(order_ids, |id| {
			heap_insert(&mut minHeap, id);
			heap_insert(&mut maxHeap, id);
		});

		vector::for_each(prices_ascending, |price| {
			let head_order = fetch_order_ref(heap_head(&minHeap));
			assert!(head_order.price == price, passed);
			passed = passed + 1;
			heap_pop(&mut minHeap);
		});

		vector::for_each(prices_descending, |price| {
			let head_order = fetch_order_ref(heap_head(&maxHeap));
			assert!(head_order.price == price, passed);
			passed = passed + 1;
			heap_pop(&mut maxHeap);
		});
	}

	#[test(user = @resource_account)]
	fun test_heap_match(user: signer) acquires OrderStore {
		initialize_module(&user);

		let minHeap = MinHeap();
		let prices = vector[10u64, 12u64, 11u64, 15u64];
		let units = vector[2u64, 5, 6, 3];
		let users = vector[@0x11, @0x12, @0x13, @0x14];
		let order_ids = vector<u64>[];

		while (!vector::is_empty(&prices)) {
			vector::push_back(&mut order_ids, newOrder(
				vector::pop_back(&mut prices),
				vector::pop_back(&mut units),
				vector::pop_back(&mut users),
				constants::Limit(),
				false,
				constants::Active(),
				constants::Short(),
				0xFEE,
			));
		};

		vector::for_each_reverse(order_ids, |id| {
			heap_insert(&mut minHeap, id);
		});

		let buy_price = 11;
		let buy_units = 9;
		let buy_order = newOrder(
			buy_price,
			buy_units,
			@0xC0FFEE,
			constants::Limit(),
			true,
			constants::Active(),
			constants::Long(),
			0xFEE,
		);

		let (matched_units, _) = heap_match(&mut minHeap, buy_order);

		assert!(matched_units == 8, 0u64);
	}
}
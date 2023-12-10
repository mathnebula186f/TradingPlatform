/**
* Module with functions for 
* Heap of Orders
*/
module resource_account::order {
	use std::vector;
	use resource_account::constants;
	use aptos_framework::table::{Self, Table};
	use aptos_framework::timestamp;

	friend resource_account::trading_platform;

	const MAX_HEAP: u8 = 0;
	const MIN_HEAP: u8 = 1;

	struct Order has store {
		price: u64,
		units: u64,
		timestamp: u64,

		from: address,
		id: u64,
		positions: vector<u64>,

		type: u8,
		flexible: bool,

		state: u8,
	}

	struct OrderHeap has store, drop {
		arr: vector<PriceLevel>,
		type: u8
	}

	struct PriceLevel has store, drop {
		price: u64,
		fixedOrders: vector<u64>,
		flexibleOrders: vector<u64>,
	}
	
	struct OrderStore has key {
		orders: Table<u64, Order>,
		id: u64,
	}

	public fun MaxHeap() : (OrderHeap) {
		OrderHeap {
			arr: vector::empty<PriceLevel>(),
			type: MAX_HEAP
		}
	}

	public fun MinHeap() : (OrderHeap) {
		OrderHeap {
			arr: vector::empty<PriceLevel>(),
			type: MIN_HEAP,
		}
	}

	entry fun init_module(admin: &signer) {
		let order_table = table::new<u64, Order>();
		table::add(&mut order_table, 0, Order {
			price: 0,
			units: 0,
			from: @0x0,
			positions: vector::empty<u64>(),
			flexible: false,
			type: 0,
			state: 0,
			id: 0,
			timestamp: 0,
		});
		move_to(admin, OrderStore {
			orders: order_table,
			id: 1,
		});
	}

	/**
	*	Insert a new Order
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
	*	Try to pair `units` units for a given price
	*/
	public fun heap_match(heap: &mut OrderHeap, id: u64) : (u64, vector<u64>) acquires OrderStore {
		let order = fetch_order_ref(id);

		let matched = vector::empty<u64>();
		let matchedUnits = 0u64;
		let requiredUnits = order.units;
		let targetPrice = order.price;

		loop {

			if (vector::length(&heap.arr) == 0)	break;

			let head = head_pricelevel_mut(heap);

			if (heap.type == MIN_HEAP && head.price > targetPrice)	break;
			if (heap.type == MAX_HEAP && head.price < targetPrice)	break;
			
			loop {
				if (matchedUnits >= requiredUnits) break;

				let storage = borrow_global<OrderStore>(@resource_account);
				let top_fixed_order = best_fixed_order(head, storage);
				let top_flex_order = best_flex_order(head, storage);
				let next_candidate = best_order(top_fixed_order, top_flex_order);
				
				if (! is_valid(next_candidate)) {
					pop_pricelevel(heap);
					break
				};

				let fixed = (top_fixed_order == next_candidate);

				if (next_candidate.state == constants::Cancelled()){
					let vec = if (fixed) &mut head.fixedOrders else &mut head.flexibleOrders ;
					pop_from_timestamp_heap(vec);
					continue
				};

				matchedUnits = matchedUnits + next_candidate.units;
				vector::push_back(&mut matched, next_candidate.id);

				let vec = if (fixed) &mut head.fixedOrders else &mut head.flexibleOrders ;
				pop_from_timestamp_heap(vec);
			};

			if (matchedUnits >= requiredUnits) break;
		};

		(matchedUnits, matched)
	}

	/**
	*	Return the order on top
	*/
	public fun heap_head(heap: &OrderHeap): u64 acquires OrderStore {
		let storage = borrow_global<OrderStore>(@resource_account);

		let top = vector::borrow(& heap.arr, 0);

		let top_fixed_order = best_fixed_order(top, storage);
		let top_flex_order = best_flex_order(top, storage);

		let top_order = best_order(top_fixed_order, top_flex_order) ;

		top_order.id
	}

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

	public fun heap_is_empty(heap: & OrderHeap): bool acquires OrderStore {
		let head = heap_head(heap);
		head == 0
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
			if (top_fixed_order.timestamp < top_flex_order.timestamp) top_fixed_order else top_flex_order
		} else if (is_valid(top_fixed_order)) top_fixed_order else top_flex_order
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

	fun pop_pricelevel(heap: &mut OrderHeap) acquires OrderStore {
		vector::swap_remove(&mut heap.arr, 0);
		let root = 0u64;

		heapify(heap, root);
	}


	/**
	*	Getters and setters for
	*	the constants::Order type
	*/

	public(friend) fun newOrder(
		price: u64,
		units: u64,
		from: address,
		type: u8,
		flexible: bool,
		state: u8,
	) : u64 acquires OrderStore {
		let storage = borrow_global_mut<OrderStore>(@resource_account);
		let id = storage.id;
		storage.id = id + 1;
		table::add(&mut storage.orders, id, Order {
			price,
			units,
			timestamp: aptos_framework::timestamp::now_microseconds(),

			from,
			id,
			positions: vector::empty<u64>(),

			type, 
			flexible,

			state,
		});
		id
	}

	public fun set_state(order: u64, state: u8) acquires OrderStore {
		fetch_order_ref_mut(order).state = state;
	}

	public fun set_units(order: u64, units: u64) acquires OrderStore {
		fetch_order_ref_mut(order).units = units;
	}

	public fun set_fixed(order: u64) acquires OrderStore {
		fetch_order_ref_mut(order).flexible = false;
	}

	public fun add_position(order: u64, position: u64) acquires OrderStore {
		vector::push_back(&mut fetch_order_ref_mut(order).positions, position);
	}

	public fun from(order: u64): address acquires OrderStore {
		fetch_order_ref(order).from
	}

	public fun price(order: u64) : (u64) acquires OrderStore {
		fetch_order_ref(order).price
	}

	public fun units(order: u64) : (u64) acquires OrderStore {
		fetch_order_ref(order).units
	}

	public fun state(order: u64) : (u8) acquires OrderStore {
		fetch_order_ref(order).state
	}

	public fun type(order: u64): (u8) acquires OrderStore {
		fetch_order_ref(order).type
	}

	public fun time(order: u64): (u64) acquires OrderStore {
		fetch_order_ref(order).timestamp
	}

	public fun is_flexible(order: u64): bool acquires OrderStore {
		fetch_order_ref(order).flexible
	}


	inline fun fetch_order_ref(order: u64): &Order acquires OrderStore {
		table::borrow(&borrow_global<OrderStore>(@resource_account).orders, order)
	}

	inline fun fetch_order_ref_mut(order: u64): &mut Order acquires OrderStore {
		table::borrow_mut(&mut borrow_global_mut<OrderStore>(@resource_account).orders, order)
	}

	#[test_only]
	public fun initialize_module(admin: &signer) {
		let framework = aptos_framework::account::create_account_for_test(@aptos_framework);
		let vm = aptos_framework::account::create_account_for_test(@vm_reserved);
		timestamp::set_time_has_started_for_testing(&framework);
		timestamp::update_global_time(&vm, @publisher_addr, 1);
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
				constants::Sell(),
				false,
				constants::Active(),
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
			assert!(head_order.units == units, passed);
			passed = passed + 1;
			heap_pop(&mut minHeap);
		});

		vector::zip(prices_descending, units_descending, |price, units| {
			let head_order = fetch_order_ref(heap_head(&maxHeap));
			assert!(head_order.price == price, passed);
			passed = passed + 1;
			assert!(head_order.units == units, passed);
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
				constants::Sell(),
				false,
				constants::Active(),
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
				constants::Sell(),
				vector::pop_back(&mut flexibility),
				constants::Active(),
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
				constants::Sell(),
				false,
				constants::Active(),
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
			constants::Buy(),
			true,
			constants::Active(),
		);

		let (matched_units, _) = heap_match(&mut minHeap, buy_order);

		assert!(matched_units == 8, 0u64);
	}
}
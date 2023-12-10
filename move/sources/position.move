module resource_account::position {
	use aptos_framework::table::{Self, Table};
	use resource_account::constants;
	use aptos_framework::timestamp;

	friend resource_account::trading_platform;

	struct Position has store {
		position_id: u64,
		order_id: u64,
		type: u8,
		strike_price: u64,
		strike_units: u64,
		topup_amount: u64,
		expiration_time: u64,
	}

	struct PositionStore has key {
		positions: Table<u64, Position>,
		id: u64,
	}

	entry fun init_module(admin: &signer) {
		let position_table = table::new<u64, Position>();
		move_to(admin, PositionStore {
			positions: position_table,
			id: 1,
		});
	}

	public(friend) fun open_position(
		order_id: u64,
		type: u8,
		strike_price: u64,
		strike_units: u64,
		expiration_time: u64,
	) : u64 acquires PositionStore {
		let storage = borrow_global_mut<PositionStore>(@resource_account);
		let id = storage.id;
		storage.id = id + 1;
		table::add(&mut storage.positions, id, Position {
			position_id: id,
			strike_price,
			strike_units,
			order_id,
			type,
			expiration_time,
			topup_amount: 0,
		});
		id
	}

	public fun is_expired(position: u64): bool acquires PositionStore {
		fetch_position_ref(position).expiration_time < timestamp::now_microseconds()
	}

	public fun is_long(position: u64): bool acquires PositionStore {
		fetch_position_ref(position).type  == constants::Long()
	}

	public fun strike_price(position: u64): u64 acquires PositionStore {
		fetch_position_ref(position).strike_price
	}

	public fun strike_units(position: u64): u64 acquires PositionStore {
		fetch_position_ref(position).strike_units
	}

	public fun order(position: u64): u64 acquires PositionStore {
		fetch_position_ref(position).order_id
	}
	
	inline fun fetch_position_ref(position: u64): &Position acquires PositionStore {
		table::borrow(&borrow_global<PositionStore>(@resource_account).positions, position)
	}

	inline fun fetch_position_ref_mut(position: u64): &mut Position acquires PositionStore {
		table::borrow_mut(&mut borrow_global_mut<PositionStore>(@resource_account).positions, position)
	}
}
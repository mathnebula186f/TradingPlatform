/**
* Module for handling generation of Orders
*/
module resource_account::constants {
	//	Types
	const MARKET: u8 = 0;
	const LIMIT: u8 = 1;

	// Positions
	const LONG: u8 = 0;
	const SHORT: u8 = 1;
	const CLOSED: u8 = 2;

	// States
	const ACTIVE: u8 = 0;
	const FILLED: u8 = 1;
	const CANCELLED: u8 = 2;
	const PARTIAL_FILLED: u8 = 3;
	const FAILED: u8 = 4;

	public fun Market(): u8 {
		MARKET
	}

	public fun Limit(): u8 {
		LIMIT
	}

	public fun Long(): u8 {
		LONG
	}

	public fun Short(): u8 {
		SHORT
	}

	public fun Closed(): u8 {
		CLOSED
	}

	public fun Active(): u8 {
		ACTIVE
	}

	public fun Filled(): u8 {
		FILLED
	}

	public fun Cancelled(): u8 {
		CANCELLED
	}

	public fun Partial(): u8 {
		PARTIAL_FILLED
	}

	public fun Failed(): u8 {
		FAILED
	}
}
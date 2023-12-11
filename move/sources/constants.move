/**
* Module for declaring and accessing constants
*/
module resource_account::constants {
	//	Types
	const MARKET: u8 = 0;
	const LIMIT: u8 = 1;

	// Positions
	const LONG: u8 = 0;
	const SHORT: u8 = 1;

	// States
	const ACTIVE: u8 = 0;
	const FILLED: u8 = 1;
	const CANCELLED: u8 = 2;
	const PARTIAL_FILLED: u8 = 3;
	const FAILED: u8 = 4;

	/// Market Order
	public fun Market(): u8 {
		MARKET
	}

	/// Limit Order
	public fun Limit(): u8 {
		LIMIT
	}

	/// Long position
	public fun Long(): u8 {
		LONG
	}

	/// Short position
	public fun Short(): u8 {
		SHORT
	}

	/// Order is currently finding settlers
	public fun Active(): u8 {
		ACTIVE
	}

	/// Order has been filled
	public fun Filled(): u8 {
		FILLED
	}

	/// Order has been cancelled
	public fun Cancelled(): u8 {
		CANCELLED
	}

	/// Order has been partially filled - Only for flexible orders
	public fun Partial(): u8 {
		PARTIAL_FILLED
	}

	/// Order failed to execute
	public fun Failed(): u8 {
		FAILED
	}
}
/**
* Module for handling generation of Orders
*/
module resource_account::constants {
	const BUY: u8 = 0;
	const SELL: u8 = 1;

	const ACTIVE: u8 = 0;
	const FULFILLED: u8 = 1;
	const CANCELLED: u8 = 2;
	const PARTIAL_FILLED: u8 = 3;

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

	public fun Partial(): u8 {
		PARTIAL_FILLED
	}
}
/**
* Dummy coin only for testing purposes
*/
module resource_account::coins {
	use aptos_framework::managed_coin;

	struct BTC {}
	struct USDT {}
	struct ETH {}
	struct APT {}

	entry fun init_module(admin: &signer) {
		managed_coin::initialize<BTC>(admin, b"DummyCoin", b"DCOIN", 8, true);
		managed_coin::initialize<USDT>(admin, b"DummyCoin", b"DCOIN", 8, true);
		managed_coin::initialize<ETH>(admin, b"DummyCoin", b"DCOIN", 8, true);
		managed_coin::initialize<APT>(admin, b"DummyCoin", b"DCOIN", 8, true);
	}

	#[test_only]
	public fun initialize_module(admin: &signer) {
		init_module(admin);
	}
}
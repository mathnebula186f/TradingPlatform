/**
* Dummy coin only for testing purposes
*/
module resource_account::dummy_coin {
	use aptos_framework::managed_coin;

	struct DummyCoin {}

	entry fun init_module(admin: &signer) {
		managed_coin::initialize<DummyCoin>(admin, b"DummyCoin", b"DCOIN", 8, true);
	}

	public entry fun mint(admin: &signer, destination: address, amount: u64) {
		managed_coin::mint<DummyCoin>(admin, destination, amount);
	}

	public entry fun register(user: &signer) {
		managed_coin::register<DummyCoin>(user);
	}

	#[test_only]
	public fun initialize_module(admin: &signer) {
		init_module(admin);
	}
}
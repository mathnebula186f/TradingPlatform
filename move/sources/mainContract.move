module ContractAddr::contract {
	use std::signer;
	use std::vector;
	use aptos_framework::account::{Self, SignerCapability};

	struct ContractStorage has key {
		sellOrders : vector<Order>,
		buyOrders : vector<Order>
	}

	struct Order has store {
		price: u64,
		units: u64,
		bidder: address,
		active: bool
	}

	struct UserResource has key {	
		activeOrders: vector<Order>,
	}

	entry fun init_module(sender: &signer) {
		move_to(sender,  ContractStorage {
			sellOrders: vector<Order>[],
			buyOrders: vector<Order>[]
		});
	}

	entry fun register(sender: &signer) {
		let user_resource = UserResource {
			activeOrders: vector<Order>[]
		};

		move_to(sender, user_resource);
	}

	entry fun sell_request(seller: &signer, price: u64, units: u64) acquires ContractStorage {
		let contractStore = borrow_global_mut<ContractStorage>(@ContractAddr);
		vector::push_back<Order>(&mut contractStore.sellOrders, Order {
			price,
			units,
			bidder: signer::address_of(seller),
			active: true
		});
	}
}
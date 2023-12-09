echo -n "Enter a seed string: "
read seed
mv Move.toml backup_move.toml
mv publish_move.toml Move.toml
aptos move create-resource-account-and-publish-package --address-name resource_account --seed $seed $@
mv Move.toml publish_move.toml
mv backup_move.toml Move.toml
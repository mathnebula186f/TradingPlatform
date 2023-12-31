_aptos() {
    local i cur prev opts cmd
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd=""
    opts=""

    for i in ${COMP_WORDS[@]}
    do
        case "${cmd},${i}" in
            ",$1")
                cmd="aptos"
                ;;
            aptos,account)
                cmd="aptos__account"
                ;;
            aptos,config)
                cmd="aptos__config"
                ;;
            aptos,genesis)
                cmd="aptos__genesis"
                ;;
            aptos,governance)
                cmd="aptos__governance"
                ;;
            aptos,help)
                cmd="aptos__help"
                ;;
            aptos,info)
                cmd="aptos__info"
                ;;
            aptos,init)
                cmd="aptos__init"
                ;;
            aptos,key)
                cmd="aptos__key"
                ;;
            aptos,move)
                cmd="aptos__move"
                ;;
            aptos,multisig)
                cmd="aptos__multisig"
                ;;
            aptos,node)
                cmd="aptos__node"
                ;;
            aptos,stake)
                cmd="aptos__stake"
                ;;
            aptos,update)
                cmd="aptos__update"
                ;;
            aptos__account,create)
                cmd="aptos__account__create"
                ;;
            aptos__account,create-resource-account)
                cmd="aptos__account__create__resource__account"
                ;;
            aptos__account,derive-resource-account-address)
                cmd="aptos__account__derive__resource__account__address"
                ;;
            aptos__account,fund-with-faucet)
                cmd="aptos__account__fund__with__faucet"
                ;;
            aptos__account,help)
                cmd="aptos__account__help"
                ;;
            aptos__account,list)
                cmd="aptos__account__list"
                ;;
            aptos__account,lookup-address)
                cmd="aptos__account__lookup__address"
                ;;
            aptos__account,rotate-key)
                cmd="aptos__account__rotate__key"
                ;;
            aptos__account,transfer)
                cmd="aptos__account__transfer"
                ;;
            aptos__account__help,create)
                cmd="aptos__account__help__create"
                ;;
            aptos__account__help,create-resource-account)
                cmd="aptos__account__help__create__resource__account"
                ;;
            aptos__account__help,derive-resource-account-address)
                cmd="aptos__account__help__derive__resource__account__address"
                ;;
            aptos__account__help,fund-with-faucet)
                cmd="aptos__account__help__fund__with__faucet"
                ;;
            aptos__account__help,help)
                cmd="aptos__account__help__help"
                ;;
            aptos__account__help,list)
                cmd="aptos__account__help__list"
                ;;
            aptos__account__help,lookup-address)
                cmd="aptos__account__help__lookup__address"
                ;;
            aptos__account__help,rotate-key)
                cmd="aptos__account__help__rotate__key"
                ;;
            aptos__account__help,transfer)
                cmd="aptos__account__help__transfer"
                ;;
            aptos__config,generate-shell-completions)
                cmd="aptos__config__generate__shell__completions"
                ;;
            aptos__config,help)
                cmd="aptos__config__help"
                ;;
            aptos__config,set-global-config)
                cmd="aptos__config__set__global__config"
                ;;
            aptos__config,show-global-config)
                cmd="aptos__config__show__global__config"
                ;;
            aptos__config,show-profiles)
                cmd="aptos__config__show__profiles"
                ;;
            aptos__config__help,generate-shell-completions)
                cmd="aptos__config__help__generate__shell__completions"
                ;;
            aptos__config__help,help)
                cmd="aptos__config__help__help"
                ;;
            aptos__config__help,set-global-config)
                cmd="aptos__config__help__set__global__config"
                ;;
            aptos__config__help,show-global-config)
                cmd="aptos__config__help__show__global__config"
                ;;
            aptos__config__help,show-profiles)
                cmd="aptos__config__help__show__profiles"
                ;;
            aptos__genesis,generate-admin-write-set)
                cmd="aptos__genesis__generate__admin__write__set"
                ;;
            aptos__genesis,generate-genesis)
                cmd="aptos__genesis__generate__genesis"
                ;;
            aptos__genesis,generate-keys)
                cmd="aptos__genesis__generate__keys"
                ;;
            aptos__genesis,generate-layout-template)
                cmd="aptos__genesis__generate__layout__template"
                ;;
            aptos__genesis,get-pool-addresses)
                cmd="aptos__genesis__get__pool__addresses"
                ;;
            aptos__genesis,help)
                cmd="aptos__genesis__help"
                ;;
            aptos__genesis,set-validator-configuration)
                cmd="aptos__genesis__set__validator__configuration"
                ;;
            aptos__genesis,setup-git)
                cmd="aptos__genesis__setup__git"
                ;;
            aptos__genesis__help,generate-admin-write-set)
                cmd="aptos__genesis__help__generate__admin__write__set"
                ;;
            aptos__genesis__help,generate-genesis)
                cmd="aptos__genesis__help__generate__genesis"
                ;;
            aptos__genesis__help,generate-keys)
                cmd="aptos__genesis__help__generate__keys"
                ;;
            aptos__genesis__help,generate-layout-template)
                cmd="aptos__genesis__help__generate__layout__template"
                ;;
            aptos__genesis__help,get-pool-addresses)
                cmd="aptos__genesis__help__get__pool__addresses"
                ;;
            aptos__genesis__help,help)
                cmd="aptos__genesis__help__help"
                ;;
            aptos__genesis__help,set-validator-configuration)
                cmd="aptos__genesis__help__set__validator__configuration"
                ;;
            aptos__genesis__help,setup-git)
                cmd="aptos__genesis__help__setup__git"
                ;;
            aptos__governance,approve-execution-hash)
                cmd="aptos__governance__approve__execution__hash"
                ;;
            aptos__governance,delegation-pool)
                cmd="aptos__governance__delegation__pool"
                ;;
            aptos__governance,execute-proposal)
                cmd="aptos__governance__execute__proposal"
                ;;
            aptos__governance,generate-upgrade-proposal)
                cmd="aptos__governance__generate__upgrade__proposal"
                ;;
            aptos__governance,help)
                cmd="aptos__governance__help"
                ;;
            aptos__governance,list-proposals)
                cmd="aptos__governance__list__proposals"
                ;;
            aptos__governance,propose)
                cmd="aptos__governance__propose"
                ;;
            aptos__governance,show-proposal)
                cmd="aptos__governance__show__proposal"
                ;;
            aptos__governance,verify-proposal)
                cmd="aptos__governance__verify__proposal"
                ;;
            aptos__governance,vote)
                cmd="aptos__governance__vote"
                ;;
            aptos__governance__delegation__pool,help)
                cmd="aptos__governance__delegation__pool__help"
                ;;
            aptos__governance__delegation__pool,propose)
                cmd="aptos__governance__delegation__pool__propose"
                ;;
            aptos__governance__delegation__pool,vote)
                cmd="aptos__governance__delegation__pool__vote"
                ;;
            aptos__governance__delegation__pool__help,help)
                cmd="aptos__governance__delegation__pool__help__help"
                ;;
            aptos__governance__delegation__pool__help,propose)
                cmd="aptos__governance__delegation__pool__help__propose"
                ;;
            aptos__governance__delegation__pool__help,vote)
                cmd="aptos__governance__delegation__pool__help__vote"
                ;;
            aptos__governance__help,approve-execution-hash)
                cmd="aptos__governance__help__approve__execution__hash"
                ;;
            aptos__governance__help,delegation-pool)
                cmd="aptos__governance__help__delegation__pool"
                ;;
            aptos__governance__help,execute-proposal)
                cmd="aptos__governance__help__execute__proposal"
                ;;
            aptos__governance__help,generate-upgrade-proposal)
                cmd="aptos__governance__help__generate__upgrade__proposal"
                ;;
            aptos__governance__help,help)
                cmd="aptos__governance__help__help"
                ;;
            aptos__governance__help,list-proposals)
                cmd="aptos__governance__help__list__proposals"
                ;;
            aptos__governance__help,propose)
                cmd="aptos__governance__help__propose"
                ;;
            aptos__governance__help,show-proposal)
                cmd="aptos__governance__help__show__proposal"
                ;;
            aptos__governance__help,verify-proposal)
                cmd="aptos__governance__help__verify__proposal"
                ;;
            aptos__governance__help,vote)
                cmd="aptos__governance__help__vote"
                ;;
            aptos__governance__help__delegation__pool,propose)
                cmd="aptos__governance__help__delegation__pool__propose"
                ;;
            aptos__governance__help__delegation__pool,vote)
                cmd="aptos__governance__help__delegation__pool__vote"
                ;;
            aptos__help,account)
                cmd="aptos__help__account"
                ;;
            aptos__help,config)
                cmd="aptos__help__config"
                ;;
            aptos__help,genesis)
                cmd="aptos__help__genesis"
                ;;
            aptos__help,governance)
                cmd="aptos__help__governance"
                ;;
            aptos__help,help)
                cmd="aptos__help__help"
                ;;
            aptos__help,info)
                cmd="aptos__help__info"
                ;;
            aptos__help,init)
                cmd="aptos__help__init"
                ;;
            aptos__help,key)
                cmd="aptos__help__key"
                ;;
            aptos__help,move)
                cmd="aptos__help__move"
                ;;
            aptos__help,multisig)
                cmd="aptos__help__multisig"
                ;;
            aptos__help,node)
                cmd="aptos__help__node"
                ;;
            aptos__help,stake)
                cmd="aptos__help__stake"
                ;;
            aptos__help,update)
                cmd="aptos__help__update"
                ;;
            aptos__help__account,create)
                cmd="aptos__help__account__create"
                ;;
            aptos__help__account,create-resource-account)
                cmd="aptos__help__account__create__resource__account"
                ;;
            aptos__help__account,derive-resource-account-address)
                cmd="aptos__help__account__derive__resource__account__address"
                ;;
            aptos__help__account,fund-with-faucet)
                cmd="aptos__help__account__fund__with__faucet"
                ;;
            aptos__help__account,list)
                cmd="aptos__help__account__list"
                ;;
            aptos__help__account,lookup-address)
                cmd="aptos__help__account__lookup__address"
                ;;
            aptos__help__account,rotate-key)
                cmd="aptos__help__account__rotate__key"
                ;;
            aptos__help__account,transfer)
                cmd="aptos__help__account__transfer"
                ;;
            aptos__help__config,generate-shell-completions)
                cmd="aptos__help__config__generate__shell__completions"
                ;;
            aptos__help__config,set-global-config)
                cmd="aptos__help__config__set__global__config"
                ;;
            aptos__help__config,show-global-config)
                cmd="aptos__help__config__show__global__config"
                ;;
            aptos__help__config,show-profiles)
                cmd="aptos__help__config__show__profiles"
                ;;
            aptos__help__genesis,generate-admin-write-set)
                cmd="aptos__help__genesis__generate__admin__write__set"
                ;;
            aptos__help__genesis,generate-genesis)
                cmd="aptos__help__genesis__generate__genesis"
                ;;
            aptos__help__genesis,generate-keys)
                cmd="aptos__help__genesis__generate__keys"
                ;;
            aptos__help__genesis,generate-layout-template)
                cmd="aptos__help__genesis__generate__layout__template"
                ;;
            aptos__help__genesis,get-pool-addresses)
                cmd="aptos__help__genesis__get__pool__addresses"
                ;;
            aptos__help__genesis,set-validator-configuration)
                cmd="aptos__help__genesis__set__validator__configuration"
                ;;
            aptos__help__genesis,setup-git)
                cmd="aptos__help__genesis__setup__git"
                ;;
            aptos__help__governance,approve-execution-hash)
                cmd="aptos__help__governance__approve__execution__hash"
                ;;
            aptos__help__governance,delegation-pool)
                cmd="aptos__help__governance__delegation__pool"
                ;;
            aptos__help__governance,execute-proposal)
                cmd="aptos__help__governance__execute__proposal"
                ;;
            aptos__help__governance,generate-upgrade-proposal)
                cmd="aptos__help__governance__generate__upgrade__proposal"
                ;;
            aptos__help__governance,list-proposals)
                cmd="aptos__help__governance__list__proposals"
                ;;
            aptos__help__governance,propose)
                cmd="aptos__help__governance__propose"
                ;;
            aptos__help__governance,show-proposal)
                cmd="aptos__help__governance__show__proposal"
                ;;
            aptos__help__governance,verify-proposal)
                cmd="aptos__help__governance__verify__proposal"
                ;;
            aptos__help__governance,vote)
                cmd="aptos__help__governance__vote"
                ;;
            aptos__help__governance__delegation__pool,propose)
                cmd="aptos__help__governance__delegation__pool__propose"
                ;;
            aptos__help__governance__delegation__pool,vote)
                cmd="aptos__help__governance__delegation__pool__vote"
                ;;
            aptos__help__key,extract-peer)
                cmd="aptos__help__key__extract__peer"
                ;;
            aptos__help__key,generate)
                cmd="aptos__help__key__generate"
                ;;
            aptos__help__move,build-publish-payload)
                cmd="aptos__help__move__build__publish__payload"
                ;;
            aptos__help__move,clean)
                cmd="aptos__help__move__clean"
                ;;
            aptos__help__move,compile)
                cmd="aptos__help__move__compile"
                ;;
            aptos__help__move,compile-script)
                cmd="aptos__help__move__compile__script"
                ;;
            aptos__help__move,coverage)
                cmd="aptos__help__move__coverage"
                ;;
            aptos__help__move,create-resource-account-and-publish-package)
                cmd="aptos__help__move__create__resource__account__and__publish__package"
                ;;
            aptos__help__move,disassemble)
                cmd="aptos__help__move__disassemble"
                ;;
            aptos__help__move,document)
                cmd="aptos__help__move__document"
                ;;
            aptos__help__move,download)
                cmd="aptos__help__move__download"
                ;;
            aptos__help__move,init)
                cmd="aptos__help__move__init"
                ;;
            aptos__help__move,list)
                cmd="aptos__help__move__list"
                ;;
            aptos__help__move,prove)
                cmd="aptos__help__move__prove"
                ;;
            aptos__help__move,publish)
                cmd="aptos__help__move__publish"
                ;;
            aptos__help__move,run)
                cmd="aptos__help__move__run"
                ;;
            aptos__help__move,run-script)
                cmd="aptos__help__move__run__script"
                ;;
            aptos__help__move,show)
                cmd="aptos__help__move__show"
                ;;
            aptos__help__move,test)
                cmd="aptos__help__move__test"
                ;;
            aptos__help__move,verify-package)
                cmd="aptos__help__move__verify__package"
                ;;
            aptos__help__move,view)
                cmd="aptos__help__move__view"
                ;;
            aptos__help__move__coverage,bytecode)
                cmd="aptos__help__move__coverage__bytecode"
                ;;
            aptos__help__move__coverage,source)
                cmd="aptos__help__move__coverage__source"
                ;;
            aptos__help__move__coverage,summary)
                cmd="aptos__help__move__coverage__summary"
                ;;
            aptos__help__move__show,abi)
                cmd="aptos__help__move__show__abi"
                ;;
            aptos__help__multisig,approve)
                cmd="aptos__help__multisig__approve"
                ;;
            aptos__help__multisig,create)
                cmd="aptos__help__multisig__create"
                ;;
            aptos__help__multisig,create-transaction)
                cmd="aptos__help__multisig__create__transaction"
                ;;
            aptos__help__multisig,execute)
                cmd="aptos__help__multisig__execute"
                ;;
            aptos__help__multisig,execute-reject)
                cmd="aptos__help__multisig__execute__reject"
                ;;
            aptos__help__multisig,execute-with-payload)
                cmd="aptos__help__multisig__execute__with__payload"
                ;;
            aptos__help__multisig,reject)
                cmd="aptos__help__multisig__reject"
                ;;
            aptos__help__multisig,verify-proposal)
                cmd="aptos__help__multisig__verify__proposal"
                ;;
            aptos__help__node,analyze-validator-performance)
                cmd="aptos__help__node__analyze__validator__performance"
                ;;
            aptos__help__node,bootstrap-db)
                cmd="aptos__help__node__bootstrap__db"
                ;;
            aptos__help__node,check-network-connectivity)
                cmd="aptos__help__node__check__network__connectivity"
                ;;
            aptos__help__node,get-performance)
                cmd="aptos__help__node__get__performance"
                ;;
            aptos__help__node,get-stake-pool)
                cmd="aptos__help__node__get__stake__pool"
                ;;
            aptos__help__node,initialize-validator)
                cmd="aptos__help__node__initialize__validator"
                ;;
            aptos__help__node,join-validator-set)
                cmd="aptos__help__node__join__validator__set"
                ;;
            aptos__help__node,leave-validator-set)
                cmd="aptos__help__node__leave__validator__set"
                ;;
            aptos__help__node,run-local-testnet)
                cmd="aptos__help__node__run__local__testnet"
                ;;
            aptos__help__node,show-epoch-info)
                cmd="aptos__help__node__show__epoch__info"
                ;;
            aptos__help__node,show-validator-config)
                cmd="aptos__help__node__show__validator__config"
                ;;
            aptos__help__node,show-validator-set)
                cmd="aptos__help__node__show__validator__set"
                ;;
            aptos__help__node,show-validator-stake)
                cmd="aptos__help__node__show__validator__stake"
                ;;
            aptos__help__node,update-consensus-key)
                cmd="aptos__help__node__update__consensus__key"
                ;;
            aptos__help__node,update-validator-network-addresses)
                cmd="aptos__help__node__update__validator__network__addresses"
                ;;
            aptos__help__stake,add-stake)
                cmd="aptos__help__stake__add__stake"
                ;;
            aptos__help__stake,create-staking-contract)
                cmd="aptos__help__stake__create__staking__contract"
                ;;
            aptos__help__stake,distribute-vested-coins)
                cmd="aptos__help__stake__distribute__vested__coins"
                ;;
            aptos__help__stake,increase-lockup)
                cmd="aptos__help__stake__increase__lockup"
                ;;
            aptos__help__stake,initialize-stake-owner)
                cmd="aptos__help__stake__initialize__stake__owner"
                ;;
            aptos__help__stake,request-commission)
                cmd="aptos__help__stake__request__commission"
                ;;
            aptos__help__stake,set-delegated-voter)
                cmd="aptos__help__stake__set__delegated__voter"
                ;;
            aptos__help__stake,set-operator)
                cmd="aptos__help__stake__set__operator"
                ;;
            aptos__help__stake,unlock-stake)
                cmd="aptos__help__stake__unlock__stake"
                ;;
            aptos__help__stake,unlock-vested-coins)
                cmd="aptos__help__stake__unlock__vested__coins"
                ;;
            aptos__help__stake,withdraw-stake)
                cmd="aptos__help__stake__withdraw__stake"
                ;;
            aptos__key,extract-peer)
                cmd="aptos__key__extract__peer"
                ;;
            aptos__key,generate)
                cmd="aptos__key__generate"
                ;;
            aptos__key,help)
                cmd="aptos__key__help"
                ;;
            aptos__key__help,extract-peer)
                cmd="aptos__key__help__extract__peer"
                ;;
            aptos__key__help,generate)
                cmd="aptos__key__help__generate"
                ;;
            aptos__key__help,help)
                cmd="aptos__key__help__help"
                ;;
            aptos__move,build-publish-payload)
                cmd="aptos__move__build__publish__payload"
                ;;
            aptos__move,clean)
                cmd="aptos__move__clean"
                ;;
            aptos__move,compile)
                cmd="aptos__move__compile"
                ;;
            aptos__move,compile-script)
                cmd="aptos__move__compile__script"
                ;;
            aptos__move,coverage)
                cmd="aptos__move__coverage"
                ;;
            aptos__move,create-resource-account-and-publish-package)
                cmd="aptos__move__create__resource__account__and__publish__package"
                ;;
            aptos__move,disassemble)
                cmd="aptos__move__disassemble"
                ;;
            aptos__move,document)
                cmd="aptos__move__document"
                ;;
            aptos__move,download)
                cmd="aptos__move__download"
                ;;
            aptos__move,help)
                cmd="aptos__move__help"
                ;;
            aptos__move,init)
                cmd="aptos__move__init"
                ;;
            aptos__move,list)
                cmd="aptos__move__list"
                ;;
            aptos__move,prove)
                cmd="aptos__move__prove"
                ;;
            aptos__move,publish)
                cmd="aptos__move__publish"
                ;;
            aptos__move,run)
                cmd="aptos__move__run"
                ;;
            aptos__move,run-script)
                cmd="aptos__move__run__script"
                ;;
            aptos__move,show)
                cmd="aptos__move__show"
                ;;
            aptos__move,test)
                cmd="aptos__move__test"
                ;;
            aptos__move,verify-package)
                cmd="aptos__move__verify__package"
                ;;
            aptos__move,view)
                cmd="aptos__move__view"
                ;;
            aptos__move__coverage,bytecode)
                cmd="aptos__move__coverage__bytecode"
                ;;
            aptos__move__coverage,help)
                cmd="aptos__move__coverage__help"
                ;;
            aptos__move__coverage,source)
                cmd="aptos__move__coverage__source"
                ;;
            aptos__move__coverage,summary)
                cmd="aptos__move__coverage__summary"
                ;;
            aptos__move__coverage__help,bytecode)
                cmd="aptos__move__coverage__help__bytecode"
                ;;
            aptos__move__coverage__help,help)
                cmd="aptos__move__coverage__help__help"
                ;;
            aptos__move__coverage__help,source)
                cmd="aptos__move__coverage__help__source"
                ;;
            aptos__move__coverage__help,summary)
                cmd="aptos__move__coverage__help__summary"
                ;;
            aptos__move__help,build-publish-payload)
                cmd="aptos__move__help__build__publish__payload"
                ;;
            aptos__move__help,clean)
                cmd="aptos__move__help__clean"
                ;;
            aptos__move__help,compile)
                cmd="aptos__move__help__compile"
                ;;
            aptos__move__help,compile-script)
                cmd="aptos__move__help__compile__script"
                ;;
            aptos__move__help,coverage)
                cmd="aptos__move__help__coverage"
                ;;
            aptos__move__help,create-resource-account-and-publish-package)
                cmd="aptos__move__help__create__resource__account__and__publish__package"
                ;;
            aptos__move__help,disassemble)
                cmd="aptos__move__help__disassemble"
                ;;
            aptos__move__help,document)
                cmd="aptos__move__help__document"
                ;;
            aptos__move__help,download)
                cmd="aptos__move__help__download"
                ;;
            aptos__move__help,help)
                cmd="aptos__move__help__help"
                ;;
            aptos__move__help,init)
                cmd="aptos__move__help__init"
                ;;
            aptos__move__help,list)
                cmd="aptos__move__help__list"
                ;;
            aptos__move__help,prove)
                cmd="aptos__move__help__prove"
                ;;
            aptos__move__help,publish)
                cmd="aptos__move__help__publish"
                ;;
            aptos__move__help,run)
                cmd="aptos__move__help__run"
                ;;
            aptos__move__help,run-script)
                cmd="aptos__move__help__run__script"
                ;;
            aptos__move__help,show)
                cmd="aptos__move__help__show"
                ;;
            aptos__move__help,test)
                cmd="aptos__move__help__test"
                ;;
            aptos__move__help,verify-package)
                cmd="aptos__move__help__verify__package"
                ;;
            aptos__move__help,view)
                cmd="aptos__move__help__view"
                ;;
            aptos__move__help__coverage,bytecode)
                cmd="aptos__move__help__coverage__bytecode"
                ;;
            aptos__move__help__coverage,source)
                cmd="aptos__move__help__coverage__source"
                ;;
            aptos__move__help__coverage,summary)
                cmd="aptos__move__help__coverage__summary"
                ;;
            aptos__move__help__show,abi)
                cmd="aptos__move__help__show__abi"
                ;;
            aptos__move__show,abi)
                cmd="aptos__move__show__abi"
                ;;
            aptos__move__show,help)
                cmd="aptos__move__show__help"
                ;;
            aptos__move__show__help,abi)
                cmd="aptos__move__show__help__abi"
                ;;
            aptos__move__show__help,help)
                cmd="aptos__move__show__help__help"
                ;;
            aptos__multisig,approve)
                cmd="aptos__multisig__approve"
                ;;
            aptos__multisig,create)
                cmd="aptos__multisig__create"
                ;;
            aptos__multisig,create-transaction)
                cmd="aptos__multisig__create__transaction"
                ;;
            aptos__multisig,execute)
                cmd="aptos__multisig__execute"
                ;;
            aptos__multisig,execute-reject)
                cmd="aptos__multisig__execute__reject"
                ;;
            aptos__multisig,execute-with-payload)
                cmd="aptos__multisig__execute__with__payload"
                ;;
            aptos__multisig,help)
                cmd="aptos__multisig__help"
                ;;
            aptos__multisig,reject)
                cmd="aptos__multisig__reject"
                ;;
            aptos__multisig,verify-proposal)
                cmd="aptos__multisig__verify__proposal"
                ;;
            aptos__multisig__help,approve)
                cmd="aptos__multisig__help__approve"
                ;;
            aptos__multisig__help,create)
                cmd="aptos__multisig__help__create"
                ;;
            aptos__multisig__help,create-transaction)
                cmd="aptos__multisig__help__create__transaction"
                ;;
            aptos__multisig__help,execute)
                cmd="aptos__multisig__help__execute"
                ;;
            aptos__multisig__help,execute-reject)
                cmd="aptos__multisig__help__execute__reject"
                ;;
            aptos__multisig__help,execute-with-payload)
                cmd="aptos__multisig__help__execute__with__payload"
                ;;
            aptos__multisig__help,help)
                cmd="aptos__multisig__help__help"
                ;;
            aptos__multisig__help,reject)
                cmd="aptos__multisig__help__reject"
                ;;
            aptos__multisig__help,verify-proposal)
                cmd="aptos__multisig__help__verify__proposal"
                ;;
            aptos__node,analyze-validator-performance)
                cmd="aptos__node__analyze__validator__performance"
                ;;
            aptos__node,bootstrap-db)
                cmd="aptos__node__bootstrap__db"
                ;;
            aptos__node,check-network-connectivity)
                cmd="aptos__node__check__network__connectivity"
                ;;
            aptos__node,get-performance)
                cmd="aptos__node__get__performance"
                ;;
            aptos__node,get-stake-pool)
                cmd="aptos__node__get__stake__pool"
                ;;
            aptos__node,help)
                cmd="aptos__node__help"
                ;;
            aptos__node,initialize-validator)
                cmd="aptos__node__initialize__validator"
                ;;
            aptos__node,join-validator-set)
                cmd="aptos__node__join__validator__set"
                ;;
            aptos__node,leave-validator-set)
                cmd="aptos__node__leave__validator__set"
                ;;
            aptos__node,run-local-testnet)
                cmd="aptos__node__run__local__testnet"
                ;;
            aptos__node,show-epoch-info)
                cmd="aptos__node__show__epoch__info"
                ;;
            aptos__node,show-validator-config)
                cmd="aptos__node__show__validator__config"
                ;;
            aptos__node,show-validator-set)
                cmd="aptos__node__show__validator__set"
                ;;
            aptos__node,show-validator-stake)
                cmd="aptos__node__show__validator__stake"
                ;;
            aptos__node,update-consensus-key)
                cmd="aptos__node__update__consensus__key"
                ;;
            aptos__node,update-validator-network-addresses)
                cmd="aptos__node__update__validator__network__addresses"
                ;;
            aptos__node__help,analyze-validator-performance)
                cmd="aptos__node__help__analyze__validator__performance"
                ;;
            aptos__node__help,bootstrap-db)
                cmd="aptos__node__help__bootstrap__db"
                ;;
            aptos__node__help,check-network-connectivity)
                cmd="aptos__node__help__check__network__connectivity"
                ;;
            aptos__node__help,get-performance)
                cmd="aptos__node__help__get__performance"
                ;;
            aptos__node__help,get-stake-pool)
                cmd="aptos__node__help__get__stake__pool"
                ;;
            aptos__node__help,help)
                cmd="aptos__node__help__help"
                ;;
            aptos__node__help,initialize-validator)
                cmd="aptos__node__help__initialize__validator"
                ;;
            aptos__node__help,join-validator-set)
                cmd="aptos__node__help__join__validator__set"
                ;;
            aptos__node__help,leave-validator-set)
                cmd="aptos__node__help__leave__validator__set"
                ;;
            aptos__node__help,run-local-testnet)
                cmd="aptos__node__help__run__local__testnet"
                ;;
            aptos__node__help,show-epoch-info)
                cmd="aptos__node__help__show__epoch__info"
                ;;
            aptos__node__help,show-validator-config)
                cmd="aptos__node__help__show__validator__config"
                ;;
            aptos__node__help,show-validator-set)
                cmd="aptos__node__help__show__validator__set"
                ;;
            aptos__node__help,show-validator-stake)
                cmd="aptos__node__help__show__validator__stake"
                ;;
            aptos__node__help,update-consensus-key)
                cmd="aptos__node__help__update__consensus__key"
                ;;
            aptos__node__help,update-validator-network-addresses)
                cmd="aptos__node__help__update__validator__network__addresses"
                ;;
            aptos__stake,add-stake)
                cmd="aptos__stake__add__stake"
                ;;
            aptos__stake,create-staking-contract)
                cmd="aptos__stake__create__staking__contract"
                ;;
            aptos__stake,distribute-vested-coins)
                cmd="aptos__stake__distribute__vested__coins"
                ;;
            aptos__stake,help)
                cmd="aptos__stake__help"
                ;;
            aptos__stake,increase-lockup)
                cmd="aptos__stake__increase__lockup"
                ;;
            aptos__stake,initialize-stake-owner)
                cmd="aptos__stake__initialize__stake__owner"
                ;;
            aptos__stake,request-commission)
                cmd="aptos__stake__request__commission"
                ;;
            aptos__stake,set-delegated-voter)
                cmd="aptos__stake__set__delegated__voter"
                ;;
            aptos__stake,set-operator)
                cmd="aptos__stake__set__operator"
                ;;
            aptos__stake,unlock-stake)
                cmd="aptos__stake__unlock__stake"
                ;;
            aptos__stake,unlock-vested-coins)
                cmd="aptos__stake__unlock__vested__coins"
                ;;
            aptos__stake,withdraw-stake)
                cmd="aptos__stake__withdraw__stake"
                ;;
            aptos__stake__help,add-stake)
                cmd="aptos__stake__help__add__stake"
                ;;
            aptos__stake__help,create-staking-contract)
                cmd="aptos__stake__help__create__staking__contract"
                ;;
            aptos__stake__help,distribute-vested-coins)
                cmd="aptos__stake__help__distribute__vested__coins"
                ;;
            aptos__stake__help,help)
                cmd="aptos__stake__help__help"
                ;;
            aptos__stake__help,increase-lockup)
                cmd="aptos__stake__help__increase__lockup"
                ;;
            aptos__stake__help,initialize-stake-owner)
                cmd="aptos__stake__help__initialize__stake__owner"
                ;;
            aptos__stake__help,request-commission)
                cmd="aptos__stake__help__request__commission"
                ;;
            aptos__stake__help,set-delegated-voter)
                cmd="aptos__stake__help__set__delegated__voter"
                ;;
            aptos__stake__help,set-operator)
                cmd="aptos__stake__help__set__operator"
                ;;
            aptos__stake__help,unlock-stake)
                cmd="aptos__stake__help__unlock__stake"
                ;;
            aptos__stake__help,unlock-vested-coins)
                cmd="aptos__stake__help__unlock__vested__coins"
                ;;
            aptos__stake__help,withdraw-stake)
                cmd="aptos__stake__help__withdraw__stake"
                ;;
            *)
                ;;
        esac
    done

    case "${cmd}" in
        aptos)
            opts="-h -V --help --version account config genesis governance info init key move multisig node stake update help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account)
            opts="-h -V --help --version create create-resource-account derive-resource-account-address fund-with-faucet list lookup-address rotate-key transfer help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__create)
            opts="-h -V --account --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__create__resource__account)
            opts="-h -V --authentication-key --seed --seed-encoding --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --authentication-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --seed)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --seed-encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__derive__resource__account__address)
            opts="-h -V --address --seed --seed-encoding --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --seed)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --seed-encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__fund__with__faucet)
            opts="-h -V --account --amount --faucet-url --faucet-auth-token --url --connection-timeout-secs --node-api-key --profile --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --amount)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --faucet-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --faucet-auth-token)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__help)
            opts="create create-resource-account derive-resource-account-address fund-with-faucet list lookup-address rotate-key transfer help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__help__create)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__help__create__resource__account)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__help__derive__resource__account__address)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__help__fund__with__faucet)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__help__list)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__help__lookup__address)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__help__rotate__key)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__help__transfer)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__list)
            opts="-h -V --account --query --url --connection-timeout-secs --node-api-key --profile --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --query)
                    COMPREPLY=($(compgen -W "balance modules resources" -- "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__lookup__address)
            opts="-h -V --encoding --public-key-file --public-key --profile --url --connection-timeout-secs --node-api-key --auth-key-file --auth-key --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --public-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --public-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --auth-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --auth-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__rotate__key)
            opts="-h -V --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --new-private-key-file --new-private-key --save-to-profile --skip-saving-profile --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --new-private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --new-private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --save-to-profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__account__transfer)
            opts="-h -V --account --amount --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --amount)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__config)
            opts="-h -V --help --version generate-shell-completions set-global-config show-global-config show-profiles help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__config__generate__shell__completions)
            opts="-h -V --shell --output-file --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --shell)
                    COMPREPLY=($(compgen -W "bash elvish fish powershell zsh" -- "${cur}"))
                    return 0
                    ;;
                --output-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__config__help)
            opts="generate-shell-completions set-global-config show-global-config show-profiles help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__config__help__generate__shell__completions)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__config__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__config__help__set__global__config)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__config__help__show__global__config)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__config__help__show__profiles)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__config__set__global__config)
            opts="-h -V --config-type --default-prompt-response --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --config-type)
                    COMPREPLY=($(compgen -W "global workspace" -- "${cur}"))
                    return 0
                    ;;
                --default-prompt-response)
                    COMPREPLY=($(compgen -W "prompt yes no" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__config__show__global__config)
            opts="-h -V --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__config__show__profiles)
            opts="-h -V --profile --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis)
            opts="-h -V --help --version generate-admin-write-set generate-genesis get-pool-addresses generate-keys generate-layout-template setup-git set-validator-configuration help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__generate__admin__write__set)
            opts="-h -V --output-file --execute-as --script-path --compiled-script-path --framework-git-rev --framework-local-dir --skip-fetch-latest-git-deps --bytecode-version --assume-yes --assume-no --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --output-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --execute-as)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --script-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiled-script-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-git-rev)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-local-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__generate__genesis)
            opts="-h -V --output-dir --mainnet --assume-yes --assume-no --github-repository --github-branch --github-token-file --local-repository-dir --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --github-repository)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --github-branch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --github-token-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --local-repository-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__generate__keys)
            opts="-h -V --output-dir --pool-address --assume-yes --assume-no --random-seed --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pool-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --random-seed)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__generate__layout__template)
            opts="-h -V --output-file --assume-yes --assume-no --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --output-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__get__pool__addresses)
            opts="-h -V --output-dir --assume-yes --assume-no --github-repository --github-branch --github-token-file --local-repository-dir --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --github-repository)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --github-branch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --github-token-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --local-repository-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__help)
            opts="generate-admin-write-set generate-genesis get-pool-addresses generate-keys generate-layout-template setup-git set-validator-configuration help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__help__generate__admin__write__set)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__help__generate__genesis)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__help__generate__keys)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__help__generate__layout__template)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__help__get__pool__addresses)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__help__set__validator__configuration)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__help__setup__git)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__set__validator__configuration)
            opts="-h -V --username --validator-host --full-node-host --stake-amount --commission-percentage --join-during-genesis --owner-public-identity-file --operator-public-identity-file --voter-public-identity-file --github-repository --github-branch --github-token-file --local-repository-dir --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --username)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --validator-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --full-node-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --stake-amount)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --commission-percentage)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --owner-public-identity-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --operator-public-identity-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --voter-public-identity-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --github-repository)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --github-branch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --github-token-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --local-repository-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__genesis__setup__git)
            opts="-h -V --github-repository --github-branch --github-token-file --local-repository-dir --layout-file --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --github-repository)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --github-branch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --github-token-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --local-repository-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --layout-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance)
            opts="-h -V --help --version propose vote show-proposal list-proposals verify-proposal execute-proposal generate-upgrade-proposal approve-execution-hash delegation-pool help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__approve__execution__hash)
            opts="-h -V --proposal-id --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --proposal-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__delegation__pool)
            opts="-h -V --help --version propose vote help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__delegation__pool__help)
            opts="propose vote help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__delegation__pool__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__delegation__pool__help__propose)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__delegation__pool__help__vote)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__delegation__pool__propose)
            opts="-h -V --delegation-pool-address --metadata-url --is-multi-step --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --script-path --compiled-script-path --framework-git-rev --framework-local-dir --skip-fetch-latest-git-deps --bytecode-version --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --delegation-pool-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --metadata-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --script-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiled-script-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-git-rev)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-local-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__delegation__pool__vote)
            opts="-h -V --delegation-pool-address --proposal-id --yes --no --voting-power --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --delegation-pool-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --proposal-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --voting-power)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__execute__proposal)
            opts="-h -V --proposal-id --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --script-path --compiled-script-path --framework-git-rev --framework-local-dir --skip-fetch-latest-git-deps --bytecode-version --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --proposal-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --script-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiled-script-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-git-rev)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-local-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__generate__upgrade__proposal)
            opts="-h -V --account --output --included-artifacts --testnet --next-execution-hash --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --included-artifacts)
                    COMPREPLY=($(compgen -W "none sparse all" -- "${cur}"))
                    return 0
                    ;;
                --next-execution-hash)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help)
            opts="propose vote show-proposal list-proposals verify-proposal execute-proposal generate-upgrade-proposal approve-execution-hash delegation-pool help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help__approve__execution__hash)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help__delegation__pool)
            opts="propose vote"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help__delegation__pool__propose)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help__delegation__pool__vote)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help__execute__proposal)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help__generate__upgrade__proposal)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help__list__proposals)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help__propose)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help__show__proposal)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help__verify__proposal)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__help__vote)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__list__proposals)
            opts="-h -V --url --connection-timeout-secs --node-api-key --profile --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__propose)
            opts="-h -V --pool-address --metadata-url --is-multi-step --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --script-path --compiled-script-path --framework-git-rev --framework-local-dir --skip-fetch-latest-git-deps --bytecode-version --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --pool-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --metadata-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --script-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiled-script-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-git-rev)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-local-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__show__proposal)
            opts="-h -V --proposal-id --url --connection-timeout-secs --node-api-key --profile --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --proposal-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__verify__proposal)
            opts="-h -V --proposal-id --script-path --compiled-script-path --framework-git-rev --framework-local-dir --skip-fetch-latest-git-deps --bytecode-version --url --connection-timeout-secs --node-api-key --profile --assume-yes --assume-no --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --proposal-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --script-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiled-script-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-git-rev)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-local-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__governance__vote)
            opts="-h -V --pool-addresses --proposal-id --yes --no --voting-power --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --pool-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --proposal-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --voting-power)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help)
            opts="account config genesis governance info init key move multisig node stake update help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__account)
            opts="create create-resource-account derive-resource-account-address fund-with-faucet list lookup-address rotate-key transfer"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__account__create)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__account__create__resource__account)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__account__derive__resource__account__address)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__account__fund__with__faucet)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__account__list)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__account__lookup__address)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__account__rotate__key)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__account__transfer)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__config)
            opts="generate-shell-completions set-global-config show-global-config show-profiles"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__config__generate__shell__completions)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__config__set__global__config)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__config__show__global__config)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__config__show__profiles)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__genesis)
            opts="generate-admin-write-set generate-genesis get-pool-addresses generate-keys generate-layout-template setup-git set-validator-configuration"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__genesis__generate__admin__write__set)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__genesis__generate__genesis)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__genesis__generate__keys)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__genesis__generate__layout__template)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__genesis__get__pool__addresses)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__genesis__set__validator__configuration)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__genesis__setup__git)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__governance)
            opts="propose vote show-proposal list-proposals verify-proposal execute-proposal generate-upgrade-proposal approve-execution-hash delegation-pool"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__governance__approve__execution__hash)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__governance__delegation__pool)
            opts="propose vote"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__governance__delegation__pool__propose)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__governance__delegation__pool__vote)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__governance__execute__proposal)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__governance__generate__upgrade__proposal)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__governance__list__proposals)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__governance__propose)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__governance__show__proposal)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__governance__verify__proposal)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__governance__vote)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__info)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__init)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__key)
            opts="generate extract-peer"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__key__extract__peer)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__key__generate)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move)
            opts="build-publish-payload clean compile compile-script coverage create-resource-account-and-publish-package disassemble document download init list prove publish run run-script show test verify-package view"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__build__publish__payload)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__clean)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__compile)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__compile__script)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__coverage)
            opts="summary source bytecode"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__coverage__bytecode)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__coverage__source)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__coverage__summary)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__create__resource__account__and__publish__package)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__disassemble)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__document)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__download)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__init)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__list)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__prove)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__publish)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__run)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__run__script)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__show)
            opts="abi"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__show__abi)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__test)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__verify__package)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__move__view)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__multisig)
            opts="approve create create-transaction execute execute-reject execute-with-payload reject verify-proposal"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__multisig__approve)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__multisig__create)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__multisig__create__transaction)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__multisig__execute)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__multisig__execute__reject)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__multisig__execute__with__payload)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__multisig__reject)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__multisig__verify__proposal)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node)
            opts="analyze-validator-performance bootstrap-db check-network-connectivity get-performance get-stake-pool initialize-validator join-validator-set leave-validator-set show-epoch-info show-validator-config show-validator-set show-validator-stake run-local-testnet update-consensus-key update-validator-network-addresses"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__analyze__validator__performance)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__bootstrap__db)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__check__network__connectivity)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__get__performance)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__get__stake__pool)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__initialize__validator)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__join__validator__set)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__leave__validator__set)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__run__local__testnet)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__show__epoch__info)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__show__validator__config)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__show__validator__set)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__show__validator__stake)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__update__consensus__key)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__node__update__validator__network__addresses)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__stake)
            opts="add-stake create-staking-contract distribute-vested-coins increase-lockup initialize-stake-owner request-commission set-delegated-voter set-operator unlock-stake unlock-vested-coins withdraw-stake"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__stake__add__stake)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__stake__create__staking__contract)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__stake__distribute__vested__coins)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__stake__increase__lockup)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__stake__initialize__stake__owner)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__stake__request__commission)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__stake__set__delegated__voter)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__stake__set__operator)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__stake__unlock__stake)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__stake__unlock__vested__coins)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__stake__withdraw__stake)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__help__update)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__info)
            opts="-h -V --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__init)
            opts="-h -V --network --rest-url --faucet-url --faucet-auth-token --skip-faucet --ledger --derivation-path --derivation-index --random-seed --private-key-file --private-key --profile --assume-yes --assume-no --encoding --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --network)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --rest-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --faucet-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --faucet-auth-token)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --derivation-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --derivation-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --random-seed)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__key)
            opts="-h -V --help --version generate extract-peer help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__key__extract__peer)
            opts="-h -V --host --private-network-key-file --private-network-key --public-network-key-file --public-network-key --output-file --assume-yes --assume-no --encoding --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-network-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-network-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --public-network-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --public-network-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__key__generate)
            opts="-h -V --key-type --vanity-prefix --vanity-multisig --random-seed --output-file --assume-yes --assume-no --encoding --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --key-type)
                    COMPREPLY=($(compgen -W "ed25519 x25519 bls12381" -- "${cur}"))
                    return 0
                    ;;
                --vanity-prefix)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --random-seed)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__key__help)
            opts="generate extract-peer help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__key__help__extract__peer)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__key__help__generate)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__key__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move)
            opts="-h -V --help --version build-publish-payload clean compile compile-script coverage create-resource-account-and-publish-package disassemble document download init list prove publish run run-script show test verify-package view help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__build__publish__payload)
            opts="-h -V --override-size-check --included-artifacts --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --json-output-file --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --included-artifacts)
                    COMPREPLY=($(compgen -W "none sparse all" -- "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --json-output-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__clean)
            opts="-h -V --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --assume-yes --assume-no --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__compile)
            opts="-h -V --save-metadata --included-artifacts --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --included-artifacts)
                    COMPREPLY=($(compgen -W "none sparse all" -- "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__compile__script)
            opts="-h -V --output-file --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --output-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__coverage)
            opts="-h -V --help --version summary source bytecode help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__coverage__bytecode)
            opts="-h -V --module --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --module)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__coverage__help)
            opts="summary source bytecode help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__coverage__help__bytecode)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__coverage__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__coverage__help__source)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__coverage__help__summary)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__coverage__source)
            opts="-h -V --module --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --module)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__coverage__summary)
            opts="-f -h -V --summarize-functions --csv --filter --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --filter)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__create__resource__account__and__publish__package)
            opts="-h -V --address-name --override-size-check --seed --seed-encoding --included-artifacts --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --address-name)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --seed)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --seed-encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --included-artifacts)
                    COMPREPLY=($(compgen -W "none sparse all" -- "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__disassemble)
            opts="-h -V --is-script --bytecode-path --code-coverage-path --output-dir --assume-yes --assume-no --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --bytecode-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --code-coverage-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__document)
            opts="-h -V --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --include-impl --include-specs --specs-inlined --include-dep-diagram --collapsed-sections --landing-page-template --references-file --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                --landing-page-template)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --references-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__download)
            opts="-h -V --account --package --output-dir --url --connection-timeout-secs --node-api-key --profile --print-metadata --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help)
            opts="build-publish-payload clean compile compile-script coverage create-resource-account-and-publish-package disassemble document download init list prove publish run run-script show test verify-package view help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__build__publish__payload)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__clean)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__compile)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__compile__script)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__coverage)
            opts="summary source bytecode"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__coverage__bytecode)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__coverage__source)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__coverage__summary)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__create__resource__account__and__publish__package)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__disassemble)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__document)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__download)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__init)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__list)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__prove)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__publish)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__run)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__run__script)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__show)
            opts="abi"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__show__abi)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__test)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__verify__package)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__help__view)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__init)
            opts="-h -V --name --package-dir --named-addresses --assume-yes --assume-no --framework-git-rev --framework-local-dir --skip-fetch-latest-git-deps --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --name)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-git-rev)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-local-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__list)
            opts="-h -V --account --query --url --connection-timeout-secs --node-api-key --profile --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --query)
                    COMPREPLY=($(compgen -W "packages" -- "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__prove)
            opts="-v -f -t -h -V --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --verbosity --filter --trace --cvc5 --stratification-depth --random-seed --proc-cores --vc-timeout --disallow-global-timeout-to-be-overwritten --check-inconsistency --unconditional-abort-as-inconsistency --keep-loops --loop-unroll --stable-test-output --dump --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                --verbosity)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -v)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --filter)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --stratification-depth)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --random-seed)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --proc-cores)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --vc-timeout)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --loop-unroll)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__publish)
            opts="-h -V --override-size-check --included-artifacts --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --included-artifacts)
                    COMPREPLY=($(compgen -W "none sparse all" -- "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__run)
            opts="-h -V --function-id --type-args --args --json-file --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --function-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --type-args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --json-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__run__script)
            opts="-h -V --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --script-path --compiled-script-path --framework-git-rev --framework-local-dir --skip-fetch-latest-git-deps --bytecode-version --type-args --args --json-file --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --script-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiled-script-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-git-rev)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --framework-local-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --type-args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --json-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__show)
            opts="-h -V --help --version abi help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__show__abi)
            opts="-h -V --modules --names --included-artifacts --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --modules)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --names)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --included-artifacts)
                    COMPREPLY=($(compgen -W "none sparse all" -- "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__show__help)
            opts="abi help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__show__help__abi)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__show__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__test)
            opts="-f -i -h -V --filter --ignore-compile-warnings --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --instructions --coverage --dump --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --filter)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                --instructions)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__verify__package)
            opts="-h -V --account --included-artifacts --dev --package-dir --output-dir --named-addresses --skip-fetch-latest-git-deps --bytecode-version --compiler-version --skip-attribute-checks --check-test-code --url --connection-timeout-secs --node-api-key --profile --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --included-artifacts)
                    COMPREPLY=($(compgen -W "none sparse all" -- "${cur}"))
                    return 0
                    ;;
                --package-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --named-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bytecode-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --compiler-version)
                    COMPREPLY=($(compgen -W "v1 v2" -- "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__move__view)
            opts="-h -V --function-id --type-args --args --json-file --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --function-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --type-args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --json-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig)
            opts="-h -V --help --version approve create create-transaction execute execute-reject execute-with-payload reject verify-proposal help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__approve)
            opts="-h -V --multisig-address --sequence-number --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --multisig-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sequence-number)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__create)
            opts="-h -V --additional-owners --num-signatures-required --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --additional-owners)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --num-signatures-required)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__create__transaction)
            opts="-h -V --multisig-address --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --function-id --type-args --args --json-file --store-hash-only --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --multisig-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --function-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --type-args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --json-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__execute)
            opts="-h -V --multisig-address --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --multisig-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__execute__reject)
            opts="-h -V --multisig-address --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --multisig-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__execute__with__payload)
            opts="-h -V --multisig-address --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --function-id --type-args --args --json-file --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --multisig-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --function-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --type-args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --json-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__help)
            opts="approve create create-transaction execute execute-reject execute-with-payload reject verify-proposal help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__help__approve)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__help__create)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__help__create__transaction)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__help__execute)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__help__execute__reject)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__help__execute__with__payload)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__help__reject)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__help__verify__proposal)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__reject)
            opts="-h -V --multisig-address --sequence-number --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --multisig-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sequence-number)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__multisig__verify__proposal)
            opts="-h -V --multisig-address --sequence-number --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --function-id --type-args --args --json-file --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --multisig-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sequence-number)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --function-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --type-args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --json-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node)
            opts="-h -V --help --version analyze-validator-performance bootstrap-db check-network-connectivity get-performance get-stake-pool initialize-validator join-validator-set leave-validator-set show-epoch-info show-validator-config show-validator-set show-validator-stake run-local-testnet update-consensus-key update-validator-network-addresses help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__analyze__validator__performance)
            opts="-h -V --start-epoch --end-epoch --analyze-mode --pool-addresses --url --connection-timeout-secs --node-api-key --profile --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --start-epoch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --end-epoch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --analyze-mode)
                    COMPREPLY=($(compgen -W "all detailed-epoch-table validator-health-over-time network-health-over-time" -- "${cur}"))
                    return 0
                    ;;
                --pool-addresses)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__bootstrap__db)
            opts="-h -V --local-fs-dir --command-adapter-config --metadata-cache-dir --replay-all --ledger-history-start-version --skip-epoch-endings --dry-run --target-db-dir --target-version --trust-waypoint --ledger-db-max-open-files --ledger-db-max-total-wal-size --state-merkle-db-max-open-files --state-merkle-db-max-total-wal-size --enable-storage-sharding --state-kv-db-max-open-files --state-kv-db-max-total-wal-size --index-db-max-open-files --index-db-max-total-wal-size --max-background-jobs --concurrent-downloads --replay-concurrency-level --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --local-fs-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --command-adapter-config)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --metadata-cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --ledger-history-start-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --target-db-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --target-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --trust-waypoint)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --ledger-db-max-open-files)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --ledger-db-max-total-wal-size)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --state-merkle-db-max-open-files)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --state-merkle-db-max-total-wal-size)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --state-kv-db-max-open-files)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --state-kv-db-max-total-wal-size)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-db-max-open-files)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-db-max-total-wal-size)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-background-jobs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --concurrent-downloads)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --replay-concurrency-level)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__check__network__connectivity)
            opts="-h -V --address --chain-id --network-id --timeout-seconds --no-handshake --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --chain-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --network-id)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --timeout-seconds)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__get__performance)
            opts="-h -V --pool-address --url --connection-timeout-secs --node-api-key --profile --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --pool-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__get__stake__pool)
            opts="-h -V --owner-address --url --connection-timeout-secs --node-api-key --profile --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --owner-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help)
            opts="analyze-validator-performance bootstrap-db check-network-connectivity get-performance get-stake-pool initialize-validator join-validator-set leave-validator-set show-epoch-info show-validator-config show-validator-set show-validator-stake run-local-testnet update-consensus-key update-validator-network-addresses help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__analyze__validator__performance)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__bootstrap__db)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__check__network__connectivity)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__get__performance)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__get__stake__pool)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__initialize__validator)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__join__validator__set)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__leave__validator__set)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__run__local__testnet)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__show__epoch__info)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__show__validator__config)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__show__validator__set)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__show__validator__stake)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__update__consensus__key)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__help__update__validator__network__addresses)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__initialize__validator)
            opts="-h -V --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --operator-config-file --consensus-public-key --proof-of-possession --validator-host --validator-network-public-key --full-node-host --full-node-network-public-key --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --operator-config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --consensus-public-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --proof-of-possession)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --validator-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --validator-network-public-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --full-node-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --full-node-network-public-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__join__validator__set)
            opts="-h -V --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --pool-address --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pool-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__leave__validator__set)
            opts="-h -V --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --pool-address --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pool-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__run__local__testnet)
            opts="-h -V --test-dir --force-restart --config-path --test-config-override --seed --no-txn-stream --txn-stream-port --no-faucet --with-faucet --faucet-port --do-not-delegate --postgres-database --postgres-user --postgres-port --use-host-postgres --host-postgres-port --host-postgres-password --processors --with-indexer-api --indexer-api-port --ready-server-listen-port --assume-yes --assume-no --bind-to --log-to-stdout --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --test-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --test-config-override)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --seed)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --txn-stream-port)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --faucet-port)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --postgres-database)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --postgres-user)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --postgres-port)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --host-postgres-port)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --host-postgres-password)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --processors)
                    COMPREPLY=($(compgen -W "account_transactions_processor ans_processor coin_processor default_processor events_processor fungible_asset_processor nft_metadata_processor stake_processor token_processor token_v2_processor user_transaction_processor" -- "${cur}"))
                    return 0
                    ;;
                --indexer-api-port)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --ready-server-listen-port)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --bind-to)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__show__epoch__info)
            opts="-h -V --profile --url --connection-timeout-secs --node-api-key --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__show__validator__config)
            opts="-h -V --profile --url --connection-timeout-secs --node-api-key --pool-address --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pool-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__show__validator__set)
            opts="-h -V --profile --url --connection-timeout-secs --node-api-key --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__show__validator__stake)
            opts="-h -V --profile --url --connection-timeout-secs --node-api-key --pool-address --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pool-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__update__consensus__key)
            opts="-h -V --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --pool-address --operator-config-file --consensus-public-key --proof-of-possession --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pool-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --operator-config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --consensus-public-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --proof-of-possession)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__node__update__validator__network__addresses)
            opts="-h -V --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --pool-address --operator-config-file --validator-host --validator-network-public-key --full-node-host --full-node-network-public-key --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pool-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --operator-config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --validator-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --validator-network-public-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --full-node-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --full-node-network-public-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake)
            opts="-h -V --help --version add-stake create-staking-contract distribute-vested-coins increase-lockup initialize-stake-owner request-commission set-delegated-voter set-operator unlock-stake unlock-vested-coins withdraw-stake help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__add__stake)
            opts="-h -V --amount --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --amount)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__create__staking__contract)
            opts="-h -V --operator --voter --amount --commission-percentage --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --operator)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --voter)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --amount)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --commission-percentage)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__distribute__vested__coins)
            opts="-h -V --admin-address --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --admin-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help)
            opts="add-stake create-staking-contract distribute-vested-coins increase-lockup initialize-stake-owner request-commission set-delegated-voter set-operator unlock-stake unlock-vested-coins withdraw-stake help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help__add__stake)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help__create__staking__contract)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help__distribute__vested__coins)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help__increase__lockup)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help__initialize__stake__owner)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help__request__commission)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help__set__delegated__voter)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help__set__operator)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help__unlock__stake)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help__unlock__vested__coins)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__help__withdraw__stake)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__increase__lockup)
            opts="-h -V --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__initialize__stake__owner)
            opts="-h -V --initial-stake-amount --operator-address --voter-address --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --initial-stake-amount)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --operator-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --voter-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__request__commission)
            opts="-h -V --owner-address --operator-address --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --owner-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --operator-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__set__delegated__voter)
            opts="-h -V --voter-address --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --voter-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__set__operator)
            opts="-h -V --operator-address --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --operator-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__unlock__stake)
            opts="-h -V --amount --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --amount)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__unlock__vested__coins)
            opts="-h -V --admin-address --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --admin-address)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__stake__withdraw__stake)
            opts="-h -V --amount --sender-account --private-key-file --private-key --encoding --profile --url --connection-timeout-secs --node-api-key --gas-unit-price --max-gas --expiration-secs --assume-yes --assume-no --profile-gas --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --amount)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sender-account)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --private-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --encoding)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --profile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --connection-timeout-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --node-api-key)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gas-unit-price)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-gas)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --expiration-secs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        aptos__update)
            opts="-h -V --repo-owner --repo-name --help --version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --repo-owner)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --repo-name)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
    esac
}

complete -F _aptos -o nosort -o bashdefault -o default aptos

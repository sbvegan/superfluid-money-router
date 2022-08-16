// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/MoneyRouter.sol";
import { Superfluid } from "superfluid/superfluid/Superfluid.sol";

/**
 * To run the deploy script:
 *   1. Create a .env file
 *   2. $ source .env
 *   3. forge script script/Deploy.s.sol:DeployScript --rpc-url $GOERLI_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv
 */

contract DeployScript is Script {
    address goerliHostAddress = 0x22ff293e14F1EC3A09B137e9e06084AFd63adDF9;
    Superfluid host = Superfluid(goerliHostAddress);

    function run() public {
        vm.broadcast();
        MoneyRouter moneyRouter = new MoneyRouter(host);
        vm.stopBroadcast();
    }
}

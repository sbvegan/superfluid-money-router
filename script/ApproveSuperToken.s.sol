// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/MoneyRouter.sol";
import { ISuperToken } from "superfluid/interfaces/superfluid/ISuperfluid.sol";


/**
 * To run the approve token script:
 *   1. Deploy money router, should be already deployed
 *   2. $ source .env
 *   3. forge script script/ApproveSuperToken.s.sol:ApproveSuperTokenScript --rpc-url $GOERLI_URL --private-key $PRIVATE_KEY --broadcast -vvvv
 */
contract ApproveSuperTokenScript is Script {
    address moneyRouterAddress = 0x22ff293e14F1EC3A09B137e9e06084AFd63adDF9;
    address fDAIxAddress = 0xF2d68898557cCb2Cf4C10c3Ef2B034b2a69DAD00;

    function run() public {
        ISuperToken fDAIx = ISuperToken(fDAIxAddress);
        vm.broadcast();
        fDAIx.approve(moneyRouterAddress, 100 ether);
        vm.stopBroadcast();
    }
}

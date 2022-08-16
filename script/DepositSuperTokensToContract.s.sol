// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/MoneyRouter.sol";
import { ISuperToken } from "superfluid/interfaces/superfluid/ISuperfluid.sol";

/**
 * To run the deposit script:
 *   1. Approve tokens first so the MoneyRouter can receive tokens from our wallet
 *   2. 
 */

contract DepositScript is Script {
    event Response(bool success, bytes data);

    address moneyRouterAddress = 0x22ff293e14F1EC3A09B137e9e06084AFd63adDF9;
    address fDAIxAddress = 0xF2d68898557cCb2Cf4C10c3Ef2B034b2a69DAD00;

    function run() public {
        MoneyRouter moneyRouter = MoneyRouter(moneyRouterAddress);
        // ISuperToken fDAIx = ISuperToken(fDAIxAddress);
        vm.broadcast();
        moneyRouter.depositSuperTokensToContract(10000000000000);
        // (bool success, bytes memory data) = moneyRouterAddress.delegatecall(
        //     abi.encodeWithSelector(MoneyRouter.depositSuperTokensToContract.selector, fDAIx, 10000000000000)
        // );
        // emit Response(success, data);
        vm.stopBroadcast();
    }
}

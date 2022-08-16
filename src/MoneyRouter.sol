// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import { ISuperfluid, ISuperToken } from "superfluid/interfaces/superfluid/ISuperfluid.sol";
import { ISuperfluidToken } from "superfluid/interfaces/superfluid/ISuperfluidToken.sol";
import {IConstantFlowAgreementV1} from "superfluid/interfaces/agreements/IConstantFlowAgreementV1.sol";
import {CFAv1Library} from "superfluid/apps/CFAv1Library.sol";

contract MoneyRouter is Ownable {

    // I do not understand this code
    using CFAv1Library for CFAv1Library.InitData;
    CFAv1Library.InitData public cfaV1; //initialize cfaV1 variable

    mapping (address => bool) public accountList;

    constructor(ISuperfluid host) {

        assert(address(host) != address(0));

        //initialize InitData struct, and set equal to cfaV1        
        cfaV1 = CFAv1Library.InitData(
        host,
        //here, we are deriving the address of the CFA using the host contract
        IConstantFlowAgreementV1(
            address(host.getAgreementClass(
                    keccak256("org.superfluid-finance.agreements.ConstantFlowAgreement.v1")
                ))
            )
        );
    }

    /**
     * @notice Allows anyone to deposit SuperTokens into the contract.
     * @param token The SuperToken being deposited into the contract.
     * @param amount The amount of the SuperToken being deposited.
     */
    function depositSuperTokensToContract(ISuperToken token, uint amount) external {
        token.transferFrom(msg.sender, address(this), amount);
    }

    /**
     * @notice Allows the owner to open a CFA to an account.
     * @param token The SuperToken being streamed.
     * @param receiver The receiver of the token stream.
     * @param flowRate The rate in which the token is streamed.
     */
    function createFlowFromContract(ISuperfluidToken token, address receiver, int96 flowRate) external onlyOwner {
        cfaV1.createFlow(receiver, token, flowRate);
    }

    /**
     * @notice Allows the owner to close a CFA to an account.
     * @param token The SuperToken being streamed.
     * @param receiver The receiver of the token stream.
     */
    function deleteFlowFromContract(ISuperfluidToken token, address receiver) external {
        cfaV1.deleteFlow(address(this), receiver, token);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {CCIPReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {EventMaster} from "./EventMaster.sol";

/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES HARDCODED VALUES FOR CLARITY.
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */
contract DestinationMinter is CCIPReceiver {
    EventMaster eventMaster;
    event MintCallSuccessfull();

    constructor(address router, address eventMasterAddress) CCIPReceiver(router) {
        eventMaster = EventMaster(eventMasterAddress);
    }

    function _ccipReceive(
        Client.Any2EVMMessage memory message
    ) internal override {
        (bool success, ) = address(eventMaster).call(message.data);
        require(success);
        emit MintCallSuccessfull();
    }
}

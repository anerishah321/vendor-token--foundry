// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {Vendor} from "../src/Vendor.sol";
//import "../src/YourToken..sol";

contract Vendordeploy is Script {
    function run() external returns (Vendor) {
        vm.startBroadcast();
        Vendor vendor = new Vendor(address(this));

        vm.stopBroadcast();
        return vendor;
    }
}
//contract address =  0x90193C961A926261B756D1E5bb255e67ff9498A1

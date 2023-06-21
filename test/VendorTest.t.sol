pragma solidity ^0.8.13;
// SPDX-License-Identifier: MIT

import "forge-std/Test.sol";
import "../src/Vendor.sol";
import "../src/YourToken..sol";

contract VendorTest is Test {
    Vendor vendor;
    YourToken yourToken;

    function setUp() external payable {
        yourToken = new YourToken();
        vendor = new Vendor(address(yourToken));
        yourToken.transfer(address(vendor), 300 ether);
        console.log(address(this).balance);
        console.log(address(vendor).balance);
    }

    function testBalance() external {
        uint256 balance = yourToken.balanceOf(address(this));
        assertEq(balance, 700 ether);
        console.log(yourToken.balanceOf(address(vendor)));
    }

    function testBuyTokens() external {
        vendor.buyTokens{value: 2 ether}();
        assertEq(yourToken.balanceOf(address(vendor)), 100 ether);
        console.log(yourToken.balanceOf(address(vendor)));
    }
    //79228162514264337593543950335 - 200000000000000000000
    //100000000000000000000
    //{value:msg.value}(arg1, arg2, arg3)
}

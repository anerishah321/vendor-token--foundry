pragma solidity ^0.8.13;
// SPDX-License-Identifier: MIT

import "forge-std/Test.sol";
import "../src/Vendor.sol";
import "../src/YourToken..sol";

contract VendorTest is Test {
    Vendor vendor;
    YourToken yourToken;
    address owner;

    function setUp() external payable {
        yourToken = new YourToken();
        vendor = new Vendor(address(yourToken));
        yourToken.transfer(address(vendor), 300 ether);
        owner = address(this);
        //console.log(address(this).balance);
        console.log(address(vendor).balance);
        console.log(vendor.tokensPerEth());
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
        console.log(address(this).balance);
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.expectRevert();
        vendor.withdraw();
    }

    function testWithdraw() public payable {
        uint256 amount = 10 ether;
        payable(address(vendor)).transfer(amount);
        console.log(address(vendor).balance);
        vendor.withdraw();
        uint256 expectedVendorBalance = 0;
        assertEq(address(vendor).balance, expectedVendorBalance, "Vendor balance should be zero after withdrawal");
        console.log(address(vendor).balance);
    }

    receive() external payable {}

    fallback() external payable {}

    function testSellTokens() public payable {
        uint256 tokenAmount = 100;
        payable(address(vendor)).transfer(tokenAmount);
        yourToken.approve(address(vendor), tokenAmount);
        uint256 amountToSell = 50;
        vendor.sellTokens(amountToSell);
        uint256 expectedUserTokenBalance = 700 ether - amountToSell;
        assertEq(yourToken.balanceOf(address(this)), expectedUserTokenBalance);
    }
}

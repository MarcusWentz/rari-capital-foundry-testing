// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {ICErc20} from "../src/ICErc20.sol";
import {IERC20} from "../src/IERC20.sol";

contract ICErc20Test is Test {
    ICErc20 public icerc20;
    IERC20 public alUSD;
    address public constant addressCErc20Delegator = 0xE33928B720799127A052B65498b322A206351441;
    address public constant addressAlUSD = 0xBC6DA0FE9aD5f3b0d58160288917AA56653660E9;

    function setUp() public {
        icerc20 = ICErc20(addressCErc20Delegator);
        alUSD = IERC20(addressAlUSD);
    }

    function testRedeemUnderlyingZero() public {
        assertEq(alUSD.balanceOf(addressCErc20Delegator),1273618357846507294859);
        vm.startPrank(0x89d3FAaF37504FbB6f5Bd12f317B5caFD2545508);
        uint256 resultZero = icerc20.redeemUnderlying(0);
        assertEq(resultZero,0);
        assertEq(alUSD.balanceOf(addressCErc20Delegator),1273618357846507294859);        
    }

    function testRedeemUnderlyingOneWei() public {
        assertEq(alUSD.balanceOf(addressCErc20Delegator),1273618357846507294859);        
        vm.startPrank(0x89d3FAaF37504FbB6f5Bd12f317B5caFD2545508);
        vm.expectRevert("redeemTokens zero");
        icerc20.redeemUnderlying(1);
    }

    function testRedeemUnderlyingMax() public {
        assertEq(alUSD.balanceOf(addressCErc20Delegator),1273618357846507294859);        
        vm.startPrank(0x89d3FAaF37504FbB6f5Bd12f317B5caFD2545508);
        uint256 resultFail = icerc20.redeemUnderlying(type(uint256).max);
        assertNotEq(resultFail,0); // Not zero. Fails to redeem without revert.
        assertEq(alUSD.balanceOf(addressCErc20Delegator),1273618357846507294859);        
    }

    function testRedeemUnderlyingNullWallet() public {
        address addressNoRedeemBalance = 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045; //address vitalik.eth
        assertEq(alUSD.balanceOf(addressNoRedeemBalance),0);               
        assertEq(alUSD.balanceOf(addressCErc20Delegator),1273618357846507294859);        
        vm.startPrank(addressNoRedeemBalance);
        uint256 resultFail = icerc20.redeemUnderlying(1273618357846507294859);
        assertNotEq(resultFail,0); // Not zero. Fails to redeem without revert.
        assertEq(alUSD.balanceOf(addressCErc20Delegator),1273618357846507294859); 
        assertEq(alUSD.balanceOf(addressNoRedeemBalance),0);               
    }

    function testRedeemUnderlyingExactAmount() public {
        assertEq(alUSD.balanceOf(0x89d3FAaF37504FbB6f5Bd12f317B5caFD2545508),0);               
        assertEq(alUSD.balanceOf(addressCErc20Delegator),1273618357846507294859);        
        vm.startPrank(0x89d3FAaF37504FbB6f5Bd12f317B5caFD2545508);
        // uint256 resultZero = icerc20.redeemUnderlying(500 ether);
        // uint256 resultZero = icerc20.redeemUnderlying(1263618357846507294859);
        // uint256 resultZero = icerc20.redeemUnderlying(1273 ether);
        uint256 resultZero = icerc20.redeemUnderlying(1273618357846507294859);
        assertEq(resultZero,0);
        assertEq(alUSD.balanceOf(addressCErc20Delegator),0); 
        assertEq(alUSD.balanceOf(0x89d3FAaF37504FbB6f5Bd12f317B5caFD2545508),1273618357846507294859);               
    }
    
}

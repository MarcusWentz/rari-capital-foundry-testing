// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;
// https://github.com/Rari-Capital/fuse-v1/blob/development/src/core/CErc20.sol#L76-L84

interface ICErc20 {

    /**
     * @notice Sender redeems cTokens in exchange for a specified amount of underlying asset
     * @dev Accrues interest whether or not the operation succeeds, unless reverted
     * @param redeemAmount The amount of underlying to redeem
     * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
     */
    function redeemUnderlying(uint256 redeemAmount) external returns (uint256);
    
}
    

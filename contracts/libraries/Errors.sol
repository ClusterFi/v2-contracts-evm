// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library Errors {
    error ExitMarketGetAccountSnapshotFailed();
    error MintIsPaused();
    error BorrowIsPaused();
    error ZeroRedeemTokens();
    error SenderMustBeClToken();
    error BorrowCapReached();
    error SeizeIsPaused();
    error TransferIsPaused();
    error NotAdmin();
    error MarketAlreadyAdded();
    error NotAdminOrBorrowCapGuardian();
    error ArrayLengthMismatch();
    error MarketIsNotListed(address clToken);
    error MarketIsAlreadyListed(address clToken);
    error NotAdminOrPauseGuardian();
    error NotUnitrollerAdmin();
    error ChangeNotAuthorized();
    error InsufficientClrForGrant();
    error RepayShouldBeLessThanTotalBorrow();
    error SetCollFactorWithoutPrice();
    error InvalidCollateralFactor();
    error NonZeroBorrowBalance();
    error InsufficientLiquidity();
    error InsufficientShortfall();
    error ZeroPrice();
    error TooMuchRepay();
    error ComptrollerMismatch();
    error SenderMustBeLeverage();
    error ZeroAddress();
    error NotPendingAdmin();
    error InvalidCloseFactor();
}

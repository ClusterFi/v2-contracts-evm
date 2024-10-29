// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { AccessControl } from "@openzeppelin/contracts/access/AccessControl.sol";
import { OFT } from "@layerzerolabs/oft-evm/contracts/OFT.sol";

/**
 * @title ClusterFi OFT
 * @dev This contract implements a cross-chain token using LayerZero's OFT (Omnichain Fungible Token) standard.
 * It is designed to be deployed on the Main network and allows for cross-chain token transfers.
 * The contract includes minter and burner roles for controlled minting and burning of tokens.
 */
contract ClusterFiOFT is OFT, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    /**
     * @dev Constructor to initialize the ClusterFi's OFT token.
     * @param _name The name of the token.
     * @param _symbol The symbol of the token.
     * @param _lzEndpoint The address of the LayerZero endpoint on the Main network.
     * @param _delegate The address that will be set as the owner of the contract.
     */
    constructor(
        string memory _name,
        string memory _symbol,
        address _lzEndpoint,
        address _delegate
    ) OFT(_name, _symbol, _lzEndpoint, _delegate) Ownable(_delegate) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(BURNER_ROLE, msg.sender);
    }

    /**
     * @dev Function to mint tokens.
     * Can only be called by an account with the minter role.
     * @param to The address to mint tokens to.
     * @param amount The amount of tokens to mint.
     */
    function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    /**
     * @dev Function to burn tokens.
     * Can only be called by an account with the burner role.
     * @param from The address to burn tokens from.
     * @param amount The amount of tokens to burn.
     */
    function burn(address from, uint256 amount) external onlyRole(BURNER_ROLE) {
        _burn(from, amount);
    }
}
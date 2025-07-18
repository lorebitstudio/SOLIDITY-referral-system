// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Account Manager Contract
/// @notice Handles user account registrations and interacts with the ReferralSystem.

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/// @notice Interface for the ReferralSystem contract
interface IReferralSystem {
    /// @notice Registers a referee with a referrer
    /// @param _referee The address of the referee (the new user)
    /// @param _referrer The address of the referrer (can be 0x0)
    function registerReferrer(address _referee, address _referrer) external;

    /// @notice Returns the referrer of a given user
    /// @param _user The user address to query
    function referrerOf(address _user) external view returns (address);
}

/// @notice Manages user accounts and registers them with the ReferralSystem
contract AccountManager is ReentrancyGuard {
    /// @notice Reference to the ReferralSystem contract
    IReferralSystem public referralSystem;

    /// @notice Tracks if an address is already registered
    mapping(address => bool) public isRegistered;

    /// @notice Emitted when a new account is created
    /// @param user The address of the newly registered user
    /// @param referrer The referrer address (or 0x0 if none)
    event AccountCreated(address indexed user, address indexed referrer);

    /// @notice Initializes the AccountManager with the ReferralSystem address
    /// @param _referralSystem Address of the deployed ReferralSystem contract
    constructor(address _referralSystem) {
        referralSystem = IReferralSystem(_referralSystem);
    }

    /// @notice Register an account and automatically also as a referrer
    /// @dev Prevents double registration and self-referral
    /// @param _referrer The address of the referrer (or 0x0 if none)
    function register(address _referrer) external nonReentrant {
        require(!isRegistered[msg.sender], "Already registered");

        isRegistered[msg.sender] = true;

        // Prevent self-referral
        if (_referrer == msg.sender) {
            _referrer = address(0);
        }

        referralSystem.registerReferrer(msg.sender, _referrer);

        emit AccountCreated(msg.sender, _referrer);
    }
}
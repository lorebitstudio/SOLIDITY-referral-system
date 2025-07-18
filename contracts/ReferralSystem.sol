// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Referral System Contract
/// @notice Manages referrals, commissions, and payouts with funding and access control.
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract ReferralSystem is Ownable, AccessControl, ReentrancyGuard {
    bytes32 public constant REGISTER_ROLE = keccak256("REGISTER_ROLE");

    /// @notice Fixed commission amount per successful referral
    uint256 public constant commissionAmount = 0.0001 ether;

    /// @notice Total ETH funded into the contract
    uint256 public totalFunded;

    /// @notice Mapping of referee => referrer
    mapping(address => address) public referrerOf;

    /// @notice Mapping of referrer => accrued commissions
    mapping(address => uint256) public commissions;

    /// @notice Optional: stores the account manager (not actively used here)
    address public accountManager;

    /// @notice Emitted when a referee is registered with a referrer
    event Registered(address indexed referee, address indexed referrer);

    /// @notice Emitted when a commission is credited to a referrer
    event CommissionPaid(address indexed referrer, uint256 amount);

    /// @notice Emitted when a referrer successfully claims their commission
    event CommissionClaimed(address indexed referrer, uint256 amount);

    /// @notice Emitted when the owner or someone funds the contract
    event ReferralFunded(address indexed funder, uint256 amount);

    /// @notice Contract constructor, sets deployer as owner and admin
    constructor() Ownable(msg.sender) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    /// @notice Registers a referee with a referrer, credits commission
    /// @dev Can only be called by an account with REGISTER_ROLE
    /// @param _referee The address of the referee (the new user)
    /// @param _referrer The address of the referrer (can be 0x0)
    function registerReferrer(address _referee, address _referrer) external onlyRole(REGISTER_ROLE) {
        require(referrerOf[_referee] == address(0), "Already registered");

        if (_referrer != address(0)) {
            require(_referrer != _referee, "Self-referral not allowed");
        }

        referrerOf[_referee] = _referrer;
        emit Registered(_referee, _referrer);

        if (_referrer != address(0)) {
            commissions[_referrer] += commissionAmount;
            emit CommissionPaid(_referrer, commissionAmount);
        }
    }

    /// @notice Allows referrer to claim their accrued commissions in ETH
    function claimCommission() external nonReentrant {
        uint256 amount = commissions[msg.sender];
        require(amount > 0, "No commission");
        require(address(this).balance >= amount, "Insufficient contract funds");

        commissions[msg.sender] = 0;
        totalFunded -= amount;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");

        emit CommissionClaimed(msg.sender, amount);
    }

    /// @notice Allows owner to fund the contract for paying commissions
    function fundReferral() external payable onlyOwner {
        require(msg.value > 0, "No ETH sent");
        totalFunded += msg.value;
        emit ReferralFunded(msg.sender, msg.value);
    }

    /// @notice Allows owner to withdraw all funds from the contract
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        totalFunded = 0;

        (bool success, ) = payable(msg.sender).call{value: balance}("");
        require(success, "Withdraw failed");
    }

    /// @notice Fallback receive function, tracks any ETH sent directly to contract
    receive() external payable {
        totalFunded += msg.value;
        emit ReferralFunded(msg.sender, msg.value);
    }

    /// @notice Grants the REGISTER_ROLE to an address, enabling it to register referrals
    /// @param account Address to grant the role to
    function grantRegisterRole(address account) public onlyOwner {
        grantRole(REGISTER_ROLE, account);
    }

    /// @notice Revokes the REGISTER_ROLE from an address
    /// @param account Address to revoke the role from
    function revokeRegisterRole(address account) public onlyOwner {
        revokeRole(REGISTER_ROLE, account);
    }
}
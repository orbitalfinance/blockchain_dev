// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title PiggyBank – deposito e prelievo di Ether con time-lock opzionale
contract PiggyBank {
    mapping(address => uint256) public balance;
    uint256 public withdrawalsOpen;   // timestamp, 0 = sempre aperto
    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    constructor(uint256 lockSeconds) {
        withdrawalsOpen = lockSeconds == 0 ? 0 : block.timestamp + lockSeconds;
    }

    /// deposita Ether (msg.value > 0)
    function deposit() external payable {
        require(msg.value > 0, "zero");
        balance[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    /// prelievo solo proprio saldo
    function withdraw(uint256 amount) external {
        require(
            withdrawalsOpen == 0 || block.timestamp >= withdrawalsOpen,
            "locked"
        );
        require(balance[msg.sender] >= amount, "insuff");
        balance[msg.sender] -= amount;
        (bool ok, ) = msg.sender.call{value: amount}("");
        require(ok, "fail send");
        emit Withdraw(msg.sender, amount);
    }
}

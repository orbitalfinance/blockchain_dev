

contract Outer {
    function callInner(address _inner) external payable {
        // Qui:
        //   msg.sender  == EOA che chiama callInner
        //   msg.value   == Ether allegato dal front–end
        Inner(_inner).deposit{value: 1 ether}();
    }
}

contract Inner {
    mapping(address => uint256) public balance;

    function deposit() external payable {
        // Qui dentro:
        //   msg.sender == address di Outer  (non l'EOA!)
        //   msg.value  == 1 ether
        balance[msg.sender] += msg.value;
    }
}

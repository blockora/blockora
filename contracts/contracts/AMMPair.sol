// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IFeeManager { function process(uint256 amount) external; }

// Minimal constant-product AMM (POC). Prod me audited UniswapV2 fork use karo.
contract AMMPair {
    IERC20 public immutable token0; // e.g., BORA
    IERC20 public immutable token1;
    IFeeManager public fee;
    uint16 public swapFeeBps = 30; // 0.30%

    uint112 private reserve0;
    uint112 private reserve1;

    constructor(IERC20 _token0, IERC20 _token1, IFeeManager _fee) {
        token0 = _token0; token1 = _token1; fee = _fee;
    }

    function getReserves() public view returns (uint112, uint112) { return (reserve0, reserve1); }

    function _update(uint256 b0, uint256 b1) private { reserve0 = uint112(b0); reserve1 = uint112(b1); }

    function addLiquidity(uint256 a0, uint256 a1) external {
        token0.transferFrom(msg.sender, address(this), a0);
        token1.transferFrom(msg.sender, address(this), a1);
        _update(token0.balanceOf(address(this)), token1.balanceOf(address(this)));
    }

    function swapExact0For1(uint256 amountIn, uint256 minOut) external {
        token0.transferFrom(msg.sender, address(this), amountIn);
        (uint112 r0, uint112 r1) = getReserves();
        uint256 amountInAfterFee = amountIn * (10000 - swapFeeBps) / 10000;
        uint256 out = (amountInAfterFee * r1) / (r0 + amountInAfterFee);
        require(out >= minOut, "slip");
        token1.transfer(msg.sender, out);
        _update(token0.balanceOf(address(this)), token1.balanceOf(address(this)));
        // NOTE: Fee ko BORA me route karne ke liye path/fee-on-transfer pattern add karo (POC me skip).
    }
}

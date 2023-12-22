// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
import "./interfaces/IMoDexCoinRouter02.sol";
import "./interfaces/IERC20.sol";
import "./interfaces/IIndexLP.sol";

contract Register {
    function register(address _recipient) public returns (uint256 tokenId) {}
}
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b)
    internal
    pure
    returns (bool, uint256)
    {
    unchecked {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b)
    internal
    pure
    returns (bool, uint256)
    {
    unchecked {
        if (b > a) return (false, 0);
        return (true, a - b);
    }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b)
    internal
    pure
    returns (bool, uint256)
    {
    unchecked {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) return (true, 0);
        uint256 c = a * b;
        if (c / a != b) return (false, 0);
        return (true, c);
    }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b)
    internal
    pure
    returns (bool, uint256)
    {
    unchecked {
        if (b == 0) return (false, 0);
        return (true, a / b);
    }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b)
    internal
    pure
    returns (bool, uint256)
    {
    unchecked {
        if (b == 0) return (false, 0);
        return (true, a % b);
    }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
    unchecked {
        require(b <= a, errorMessage);
        return a - b;
    }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
    unchecked {
        require(b > 0, errorMessage);
        return a / b;
    }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
    unchecked {
        require(b > 0, errorMessage);
        return a % b;
    }
    }
}
contract PocketIndex {
    using SafeMath for uint256;

    address routerAddress;
    IERC20 public baseTokenAddress;
    IIndexLP public indexLPToken;
    address owner;
    IMoDexCoinRouter02 router;

    uint256 public lastBuyTime;
    uint256 public managementFee;
    uint256 public performanceFee;
    uint256 public totalBulkBuys;

    event NewAssetAdded(address contractAddress, uint256 timestamp);

    struct Asset {
        address contractAddress; // asset address
        uint256 balance; // current total balance
    }

    struct UserBalance {
        uint256 usdtBalance;
        mapping(address => uint256) balances;
    }

    mapping(address => UserBalance) userBalances;

    Asset[] assets;
    address[] nextBuyers;

    constructor(address _routerAddress, address _baseTokenAddress) {
        routerAddress = _routerAddress;
        baseTokenAddress = IERC20(_baseTokenAddress);
        router = IMoDexCoinRouter02(routerAddress);
        owner = msg.sender;
        totalBulkBuys = 0;
        performanceFee = 1;
        managementFee = 1;
        Register sfsContract = Register(0xBBd707815a7F7eb6897C7686274AFabd7B579Ff6); // This address is the address of the SFS contract
        sfsContract.register(msg.sender); //Registers this contract and assigns the NFT to the owner of this contract
    }

    // Add to asset array
    function addAsset(address _contractAddress) public {
        assets.push(Asset(_contractAddress, 0));
        emit NewAssetAdded(_contractAddress, block.timestamp);
    }

    // Get current asset array
    function getAllAssets() public view returns (Asset[] memory) {
        return assets;
    }

    // Bulk buy function that buys for everyone who pitched in money
    function bulkBuy() public {
        // Should only be interacted with by the owner
        require(msg.sender == owner, "Can't be interacted");

        // Must have some usdts
        require(
            baseTokenAddress.balanceOf(address(this)) > 0,
            "Don't have anything"
        );

        // Approve balance to router
        baseTokenAddress.approve(
            routerAddress,
            baseTokenAddress.balanceOf(address(this))
        );

        // Total new balance and LP token supply
        uint256 totalCurrentBalance = baseTokenAddress.balanceOf(address(this));
        if (totalBulkBuys == 0) {
            indexLPToken.mint(address(this), totalCurrentBalance);
        } else {
            uint256 totalLp = indexLPToken.totalSupply();
            uint256 one = 1000;
            // Current worth of all assets
            uint256 totalCurrentWorth = totalCurrentBalance;
            totalCurrentWorth += currentWorth();
            uint256 ratio = totalCurrentBalance.mul(1000).div(
                totalCurrentWorth
            );
            uint256 denominator = one.sub(ratio);
            uint256 newTotalLP = totalLp.mul(1000).div(denominator);
            indexLPToken.mint(address(this), newTotalLP.sub(totalLp));
        }

        // Divide total balance into 10
        uint256 equalBalance = baseTokenAddress
            .balanceOf(address(this))
            .mul(10)
            .div(100);

        // Set current time
        lastBuyTime = block.timestamp;
        // Note current balances of all assets
        uint256 totalAssets = assets.length;
        uint256[] memory currentBalances = new uint256[](assets.length);

        // Note current balances of all assets
        for (uint256 j = 0; j < totalAssets; j++) {
            // Get the amount of tokens the contract has
            currentBalances[j] = IERC20(assets[j].contractAddress)
                .balanceOf(address(this));
        }

        // Loop and buy each asset
        for (uint256 i = 0; i < totalAssets; i++) {
            address[] memory path = new address[](2);
            path[1] = assets[i].contractAddress;
            path[0] = address(baseTokenAddress);
            router.swapExactTokensForTokens(
                equalBalance,
                0,
                path,
                address(this),
                block.timestamp
            );
        }

        // Loop and buy each asset for each user
        uint256 totalBuyers = nextBuyers.length;

        // Each buyer
        for (uint256 i = 0; i < totalBuyers; i++) {
            uint256 userUsdtBalance = userBalances[nextBuyers[i]].usdtBalance;

            // Send LP to user
            indexLPToken.transfer(
                nextBuyers[i],
                indexLPToken.balanceOf(address(this)).mul(userUsdtBalance).div(
                    totalCurrentBalance
                )
            );
            uint256 userEqualBalance = userUsdtBalance.mul(10).div(100);
            // Each asset
            for (uint256 j = 0; j < totalAssets; j++) {
                // Get the amount of tokens the user has
                uint256 assetBalanceOfContract = IERC20(
                    assets[j].contractAddress
                ).balanceOf(address(this)).sub(currentBalances[j]);
                userBalances[nextBuyers[i]].balances[
                    assets[j].contractAddress
                ] += assetBalanceOfContract.mul(userEqualBalance).div(
                    equalBalance
                );
            }
            // Empty usdt balance
            userBalances[nextBuyers[i]].usdtBalance = 0;
        }

        // Empty next buyers array
        nextBuyers = new address[](0);

        // Add to total buys
        totalBulkBuys++;
    }

    function approveEverything() public {
        uint256 totalAssets = assets.length;

        // Loop and sell each asset
        for (uint256 i = 0; i < totalAssets; i++) {
            IERC20(assets[i].contractAddress).approve(
                routerAddress,
                IERC20(assets[i].contractAddress).balanceOf(
                    address(this)
                )
            );
        }
    }

    // Sell a user's balance and give him back his usdts
    function disolvePosition() public {
        require(msg.sender != owner, "Can't be interacted");
        uint256 balanceBeforeSell = baseTokenAddress.balanceOf(address(this));
        uint256 totalAssets = assets.length;
        address[] memory path = new address[](2);
        path[1] = address(baseTokenAddress);
        uint256 userBalance = 0;
        for (uint256 i = 0; i < totalAssets; i++) {
            path[0] = assets[i].contractAddress;
            userBalance = userBalances[msg.sender].balances[
                assets[i].contractAddress
            ];
            router.swapExactTokensForTokens(
                userBalance,
                0,
                path,
                address(this),
                block.timestamp + 5
            );
        }

        uint256 userUSDTBalance = baseTokenAddress.balanceOf(address(this)).sub(
            balanceBeforeSell
        );
        uint256 _managementFee = userUSDTBalance.mul(managementFee).div(1000);
        uint256 _performanceFee = userUSDTBalance.mul(performanceFee).div(1000);

        // Loop and set asset balances to 0
        for (uint256 i = 0; i < totalAssets; i++) {
            userBalances[msg.sender].balances[assets[i].contractAddress] = 0;
        }
        userBalances[msg.sender].usdtBalance += userUSDTBalance
            .sub(_managementFee)
            .sub(_performanceFee);
        baseTokenAddress.transfer(
            msg.sender,
            userBalances[msg.sender].usdtBalance
        );

        userBalances[msg.sender].usdtBalance = 0;
    }

    // Sell a user's balance and give him back his usdts according to his lp tokens
    function disolveWithLP(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(
            indexLPToken.balanceOf(msg.sender) >= amount,
            "Must have said balance"
        );
        // calculate total lp balance of user
        uint256 totalLp = indexLPToken.balanceOf(msg.sender);

        require(msg.sender != owner, "Can't be interacted");
        uint256 balanceBeforeSell = baseTokenAddress.balanceOf(address(this));
        uint256 totalAssets = assets.length;
        uint256 ratio = amount.mul(100).div(totalLp);
        address[] memory path = new address[](2);
        path[1] = address(baseTokenAddress);
        for (uint256 i = 0; i < totalAssets; i++) {
            path[0] = assets[i].contractAddress;
            uint256 userBalance = userBalances[msg.sender]
                .balances[assets[i].contractAddress]
                .mul(ratio)
                .div(100);
            router.swapExactTokensForTokens(
                userBalance,
                0,
                path,
                address(this),
                block.timestamp + 5
            );
            userBalances[msg.sender].balances[
                assets[i].contractAddress
            ] -= userBalance;
        }

        uint256 userUSDTBalance = baseTokenAddress.balanceOf(address(this)).sub(
            balanceBeforeSell
        );
        uint256 _managementFee = userUSDTBalance.mul(managementFee).div(1000);
        uint256 _performanceFee = userUSDTBalance.mul(performanceFee).div(1000);

        userBalances[msg.sender].usdtBalance += userUSDTBalance
            .sub(_managementFee)
            .sub(_performanceFee);
        baseTokenAddress.transfer(
            msg.sender,
            userBalances[msg.sender].usdtBalance
        );

        userBalances[msg.sender].usdtBalance = 0;

        // Transfer lp tokens to self and burn
        indexLPToken.transfer(address(this), amount);
        indexLPToken.burn(amount);
    }

    // New user pitches amount to bulk buy
    function pitchAmount(uint256 amount) public {
        require(
            baseTokenAddress.balanceOf(msg.sender) >= amount,
            "Don't have enough amount in e.USDT"
        );

        // Transfer the amount to the smart contract
        baseTokenAddress.transferFrom(msg.sender, address(this), amount);

        // Increment user USDT balance
        userBalances[msg.sender].usdtBalance += amount;

        // Add to next buyers array
        if (!buyerAlreadyAdded(msg.sender)) {
            nextBuyers.push(msg.sender);
        }
    }

    // Get current worth
    function currentWorth() public view returns (uint256) {
        // Current worth of all assets
        uint256 totalCurrentWorth = 0;
        address[] memory path = new address[](2);
        path[1] = address(baseTokenAddress);
        for (uint256 i = 0; i < assets.length; i++) {
            path[0] = assets[i].contractAddress;
            uint256[] memory amounts = router.getAmountsOut(
                IERC20(assets[i].contractAddress).balanceOf(
                    address(this)
                ),
                path
            );
            totalCurrentWorth += amounts[1];
        }
        return totalCurrentWorth;
    }

    // Get user's USDT balance
    function getUSDTBalance(address user) public view returns (uint256) {
        return userBalances[user].usdtBalance;
    }

    // Withdraw from user's USDT balance
    function withdrawUSDTBalance(address user, uint256 amount) public {
        require(
            userBalances[user].usdtBalance > 0,
            "Don't have anything to withdraw"
        );
        require(
            amount >= userBalances[user].usdtBalance,
            "Don't have enough amount to withdraw"
        );
        baseTokenAddress.transfer(user, amount);
    }

    // Get user's balance for all assets
    function getBalances(address user) public view returns (uint256[] memory) {
        uint256 totalAssets = assets.length;
        uint256[] memory balances = new uint256[](totalAssets);
        for (uint256 j = 0; j < totalAssets; j++) {
            balances[j] = userBalances[address(user)].balances[
                assets[j].contractAddress
            ];
        }
        return balances;
    }

    // Get user's balance for a specific asset
    function getBalance(
        address user,
        address _contractAddress
    ) public view returns (uint256) {
        return userBalances[address(user)].balances[_contractAddress];
    }

    // Get last buy time
    function getLastBuyTime() public view returns (uint256) {
        return lastBuyTime;
    }

    // Get next buyers array
    function getNextBuyers() public view returns (address[] memory) {
        return nextBuyers;
    }

    // Get total amount of assets
    function getTotalAssets() public view returns (uint256) {
        return assets.length;
    }

    // Get total amount of assets
    function getTotalBuyers() public view returns (uint256) {
        return nextBuyers.length;
    }

    // Get total amount invested in a specific asset
    function getTotalInvestedForAsset(
        address _contractAddress
    ) public view returns (uint256) {
        return IERC20(_contractAddress).balanceOf(address(this));
    }

    // set indexLPToken address
    function setIndexLPToken(address _indexLPToken) public {
        indexLPToken = IIndexLP(_indexLPToken);
    }

    // PRIVATE FUNCTIONS

    // See if user is already added to nextBuyers array
    function buyerAlreadyAdded(address buyer) internal view returns (bool) {
        uint256 totalBuyers = nextBuyers.length;
        for (uint256 i = 0; i < totalBuyers; i++) {
            if (nextBuyers[i] == buyer) {
                return true;
            }
        }
        return false;
    }
}

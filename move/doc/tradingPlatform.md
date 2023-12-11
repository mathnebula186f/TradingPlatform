
<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform"></a>

# Module `0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9::trading_platform`


* Module that will hold all the platform APIs


-  [Resource `ContractStorage`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_ContractStorage)
-  [Resource `Market`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_Market)
-  [Resource `UserResource`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_UserResource)
-  [Constants](#@Constants_0)
-  [Function `init_module`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_init_module)
-  [Function `register`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_register)
-  [Function `limit_short`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_limit_short)
-  [Function `limit_long`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_limit_long)
-  [Function `market_long`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_long)
-  [Function `market_long_units`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_long_units)
-  [Function `market_short`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_short)
-  [Function `market_short_units`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_short_units)
-  [Function `cancel_request`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_cancel_request)
-  [Function `close_order`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_close_order)
-  [Function `refill_margin`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_refill_margin)
-  [Function `market_price`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_price)


<pre><code><b>use</b> <a href="">0x1::account</a>;
<b>use</b> <a href="">0x1::aptos_coin</a>;
<b>use</b> <a href="">0x1::coin</a>;
<b>use</b> <a href="">0x1::error</a>;
<b>use</b> <a href="">0x1::math64</a>;
<b>use</b> <a href="">0x1::resource_account</a>;
<b>use</b> <a href="">0x1::signer</a>;
<b>use</b> <a href="">0x1::table</a>;
<b>use</b> <a href="">0x1::timestamp</a>;
<b>use</b> <a href="">0x1::vector</a>;
<b>use</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants">0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9::constants</a>;
<b>use</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9::order</a>;
<b>use</b> <a href="position.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position">0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9::position</a>;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_ContractStorage"></a>

## Resource `ContractStorage`


* Stores the contract's global information like signer_capabilities and expiration time



<pre><code><b>struct</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_ContractStorage">ContractStorage</a> <b>has</b> key
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_Market"></a>

## Resource `Market`


* Stores data for a futures market of asset with base for margin and settlement



<pre><code><b>struct</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_Market">Market</a>&lt;base, asset&gt; <b>has</b> key
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_UserResource"></a>

## Resource `UserResource`



<pre><code><b>struct</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_UserResource">UserResource</a> <b>has</b> key
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_BUYER_RATIO_DEN"></a>



<pre><code><b>const</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_BUYER_RATIO_DEN">BUYER_RATIO_DEN</a>: u64 = 2;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_BUYER_RATIO_NUM"></a>



<pre><code><b>const</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_BUYER_RATIO_NUM">BUYER_RATIO_NUM</a>: u64 = 1;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_EMARKET_NOT_FOUND"></a>



<pre><code><b>const</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_EMARKET_NOT_FOUND">EMARKET_NOT_FOUND</a>: u64 = 2;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_ENOT_ENOUGH_FUNDS"></a>



<pre><code><b>const</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_ENOT_ENOUGH_FUNDS">ENOT_ENOUGH_FUNDS</a>: u64 = 0;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_ENOT_ENOUGH_LIQUIDITY"></a>



<pre><code><b>const</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_ENOT_ENOUGH_LIQUIDITY">ENOT_ENOUGH_LIQUIDITY</a>: u64 = 1;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_MAX_PRICE"></a>



<pre><code><b>const</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_MAX_PRICE">MAX_PRICE</a>: u64 = 18446744073709551615;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_ONE_DAY_MS"></a>



<pre><code><b>const</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_ONE_DAY_MS">ONE_DAY_MS</a>: u64 = 8640000000000;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_SELLER_RATIO_DEN"></a>



<pre><code><b>const</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_SELLER_RATIO_DEN">SELLER_RATIO_DEN</a>: u64 = 1;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_SELLER_RATIO_NUM"></a>



<pre><code><b>const</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_SELLER_RATIO_NUM">SELLER_RATIO_NUM</a>: u64 = 2;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_init_module"></a>

## Function `init_module`


* Initialize by retrieving and storing the signer_capability



<pre><code>entry <b>fun</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_init_module">init_module</a>(admin: &<a href="">signer</a>)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_register"></a>

## Function `register`


*	Register a new user by
*	creating a resource under
*	his address



<pre><code><b>public</b> entry <b>fun</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_register">register</a>(sender: &<a href="">signer</a>)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_limit_short"></a>

## Function `limit_short`


*	Add a new sell request
*	for the seller



<pre><code><b>public</b> entry <b>fun</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_limit_short">limit_short</a>&lt;base, asset&gt;(seller: &<a href="">signer</a>, price: u64, units: u64, flexible: bool)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_limit_long"></a>

## Function `limit_long`


*	Add a new buy request
*	for the buyer



<pre><code><b>public</b> entry <b>fun</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_limit_long">limit_long</a>&lt;base, asset&gt;(buyer: &<a href="">signer</a>, price: u64, units: u64, flexible: bool)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_long"></a>

## Function `market_long`



<pre><code><b>public</b> entry <b>fun</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_long">market_long</a>&lt;base, asset&gt;(buyer: &<a href="">signer</a>, amount: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_long_units"></a>

## Function `market_long_units`



<pre><code><b>public</b> entry <b>fun</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_long_units">market_long_units</a>&lt;base, asset&gt;(buyer: &<a href="">signer</a>, num_units: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_short"></a>

## Function `market_short`



<pre><code><b>public</b> entry <b>fun</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_short">market_short</a>&lt;base, asset&gt;(seller: &<a href="">signer</a>, amount: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_short_units"></a>

## Function `market_short_units`



<pre><code><b>public</b> entry <b>fun</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_short_units">market_short_units</a>&lt;base, asset&gt;(seller: &<a href="">signer</a>, num_units: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_cancel_request"></a>

## Function `cancel_request`


*	Cancel a previuously made
*	request by the user



<pre><code><b>public</b> entry <b>fun</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_cancel_request">cancel_request</a>&lt;base, asset&gt;(user: &<a href="">signer</a>, order_id: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_close_order"></a>

## Function `close_order`



<pre><code><b>public</b> entry <b>fun</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_close_order">close_order</a>&lt;base, asset&gt;(user: &<a href="">signer</a>, order_id: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_refill_margin"></a>

## Function `refill_margin`



<pre><code><b>public</b> entry <b>fun</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_refill_margin">refill_margin</a>(user: &<a href="">signer</a>, order_id: u64, amount: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_price"></a>

## Function `market_price`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="tradingPlatform.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_trading_platform_market_price">market_price</a>&lt;base, asset&gt;(): u64
</code></pre>

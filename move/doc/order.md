
<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order"></a>

# Module `0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9::order`


* Module containing functions surrounding Orders


-  [Struct `Order`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_Order)
-  [Struct `OrderHeap`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderHeap)
-  [Struct `PriceLevel`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_PriceLevel)
-  [Resource `OrderStore`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderStore)
-  [Constants](#@Constants_0)
-  [Function `MaxHeap`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_MaxHeap)
-  [Function `MinHeap`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_MinHeap)
-  [Function `init_module`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_init_module)
-  [Function `heap_insert`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_insert)
-  [Function `heap_match`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_match)
-  [Function `heap_head`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_head)
-  [Function `heap_pop`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_pop)
-  [Function `heap_is_empty`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_is_empty)
-  [Function `newOrder`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_newOrder)
-  [Function `set_state`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_set_state)
-  [Function `set_units`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_set_units)
-  [Function `set_fixed`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_set_fixed)
-  [Function `add_position`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_add_position)
-  [Function `deposit_margin`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_deposit_margin)
-  [Function `of`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_of)
-  [Function `time`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_time)
-  [Function `list_positions`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_list_positions)
-  [Function `price`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_price)
-  [Function `units`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_units)
-  [Function `state`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_state)
-  [Function `type`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_type)
-  [Function `expiry`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_expiry)
-  [Function `margin_deposits`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_margin_deposits)
-  [Function `is_flexible`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_is_flexible)
-  [Function `is_expired`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_is_expired)
-  [Function `is_long`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_is_long)


<pre><code><b>use</b> <a href="">0x1::table</a>;
<b>use</b> <a href="">0x1::timestamp</a>;
<b>use</b> <a href="">0x1::vector</a>;
<b>use</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants">0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9::constants</a>;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_Order"></a>

## Struct `Order`


* Encapsulate data surrounding an Order



<pre><code><b>struct</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_Order">Order</a> <b>has</b> store
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderHeap"></a>

## Struct `OrderHeap`


* Store a heap of references to orders, primarily sorted by prices and then further with timestamp



<pre><code><b>struct</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderHeap">OrderHeap</a> <b>has</b> drop, store
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_PriceLevel"></a>

## Struct `PriceLevel`


* Pricelevel stores all the orders at a given pricelevel
*	- fixedOrders are orders that have to consumed atomically
*	- flexibleOrders are orders that can be consumed in parts



<pre><code><b>struct</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_PriceLevel">PriceLevel</a> <b>has</b> drop, store
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderStore"></a>

## Resource `OrderStore`


* Storage of all the orders ever generated



<pre><code><b>struct</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderStore">OrderStore</a> <b>has</b> key
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_MAX_HEAP"></a>



<pre><code><b>const</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_MAX_HEAP">MAX_HEAP</a>: u8 = 0;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_MIN_HEAP"></a>



<pre><code><b>const</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_MIN_HEAP">MIN_HEAP</a>: u8 = 1;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_MaxHeap"></a>

## Function `MaxHeap`


* Create a max heap



<pre><code><b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_MaxHeap">MaxHeap</a>(): <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderHeap">order::OrderHeap</a>
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_MinHeap"></a>

## Function `MinHeap`


* Create a min heap



<pre><code><b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_MinHeap">MinHeap</a>(): <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderHeap">order::OrderHeap</a>
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_init_module"></a>

## Function `init_module`

Initialize global order storage and id generator


<pre><code>entry <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_init_module">init_module</a>(admin: &<a href="">signer</a>)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_insert"></a>

## Function `heap_insert`


* Insert a order to the heap



<pre><code><b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_insert">heap_insert</a>(heap: &<b>mut</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderHeap">order::OrderHeap</a>, id: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_match"></a>

## Function `heap_match`


* Try to pair <code>units</code> units with a price cap (lower cap if max heap and upper cap if min heap)



<pre><code><b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_match">heap_match</a>(heap: &<b>mut</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderHeap">order::OrderHeap</a>, id: u64): (u64, <a href="">vector</a>&lt;u64&gt;)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_head"></a>

## Function `heap_head`


* Return the order on top of the heap



<pre><code><b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_head">heap_head</a>(heap: &<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderHeap">order::OrderHeap</a>): u64
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_pop"></a>

## Function `heap_pop`


* Remove and return the order on top of the heap



<pre><code><b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_pop">heap_pop</a>(heap: &<b>mut</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderHeap">order::OrderHeap</a>): u64
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_is_empty"></a>

## Function `heap_is_empty`



<pre><code><b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_heap_is_empty">heap_is_empty</a>(heap: &<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_OrderHeap">order::OrderHeap</a>): bool
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_newOrder"></a>

## Function `newOrder`


*	Getters and setters for
*	the constants::Order type

Create a new order and return its id


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_newOrder">newOrder</a>(price: u64, units: u64, of: <b>address</b>, type: u8, flexible: bool, state: u8, <a href="position.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position">position</a>: u8, expiration_time: u64): u64
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_set_state"></a>

## Function `set_state`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_set_state">set_state</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64, state: u8)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_set_units"></a>

## Function `set_units`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_set_units">set_units</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64, units: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_set_fixed"></a>

## Function `set_fixed`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_set_fixed">set_fixed</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_add_position"></a>

## Function `add_position`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_add_position">add_position</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64, <a href="position.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position">position</a>: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_deposit_margin"></a>

## Function `deposit_margin`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_deposit_margin">deposit_margin</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64, amount: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_of"></a>

## Function `of`



<pre><code><b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_of">of</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64): <b>address</b>
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_time"></a>

## Function `time`



<pre><code><b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_time">time</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64): u64
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_list_positions"></a>

## Function `list_positions`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_list_positions">list_positions</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64): <a href="">vector</a>&lt;u64&gt;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_price"></a>

## Function `price`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_price">price</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64): u64
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_units"></a>

## Function `units`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_units">units</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64): u64
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_state"></a>

## Function `state`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_state">state</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64): u8
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_type"></a>

## Function `type`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_type">type</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64): u8
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_expiry"></a>

## Function `expiry`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_expiry">expiry</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64): u64
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_margin_deposits"></a>

## Function `margin_deposits`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_margin_deposits">margin_deposits</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64): u64
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_is_flexible"></a>

## Function `is_flexible`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_is_flexible">is_flexible</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64): bool
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_is_expired"></a>

## Function `is_expired`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_is_expired">is_expired</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64): bool
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_is_long"></a>

## Function `is_long`



<pre><code><b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order_is_long">is_long</a>(<a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>: u64): bool
</code></pre>

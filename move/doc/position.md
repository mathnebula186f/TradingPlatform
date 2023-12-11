
<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position"></a>

# Module `0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9::position`


* Module containing functions surrounding Positions held by users


-  [Struct `Position`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_Position)
-  [Resource `PositionStore`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_PositionStore)
-  [Function `init_module`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_init_module)
-  [Function `open_position`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_open_position)
-  [Function `strike_price`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_strike_price)
-  [Function `strike_units`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_strike_units)
-  [Function `order`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_order)


<pre><code><b>use</b> <a href="">0x1::table</a>;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_Position"></a>

## Struct `Position`


* Encapsulate data surrounding an open postion



<pre><code><b>struct</b> <a href="position.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_Position">Position</a> <b>has</b> store
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_PositionStore"></a>

## Resource `PositionStore`


* Storage of all the positions ever held



<pre><code><b>struct</b> <a href="position.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_PositionStore">PositionStore</a> <b>has</b> key
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_init_module"></a>

## Function `init_module`

Initialize global position storage and id generator


<pre><code>entry <b>fun</b> <a href="position.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_init_module">init_module</a>(admin: &<a href="">signer</a>)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_open_position"></a>

## Function `open_position`


*	Getters and setters

Open a new position and return its id


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="position.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_open_position">open_position</a>(order_id: u64, strike_price: u64, strike_units: u64): u64
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_strike_price"></a>

## Function `strike_price`



<pre><code><b>public</b> <b>fun</b> <a href="position.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_strike_price">strike_price</a>(<a href="position.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position">position</a>: u64): u64
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_strike_units"></a>

## Function `strike_units`



<pre><code><b>public</b> <b>fun</b> <a href="position.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_strike_units">strike_units</a>(<a href="position.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position">position</a>: u64): u64
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position_order"></a>

## Function `order`



<pre><code><b>public</b> <b>fun</b> <a href="order.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_order">order</a>(<a href="position.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_position">position</a>: u64): u64
</code></pre>

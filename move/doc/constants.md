
<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants"></a>

# Module `0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9::constants`


* Module for declaring and accessing constants


-  [Constants](#@Constants_0)
-  [Function `Market`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Market)
-  [Function `Limit`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Limit)
-  [Function `Long`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Long)
-  [Function `Short`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Short)
-  [Function `Active`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Active)
-  [Function `Filled`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Filled)
-  [Function `Cancelled`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Cancelled)
-  [Function `Partial`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Partial)
-  [Function `Failed`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Failed)


<pre><code></code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_CANCELLED"></a>



<pre><code><b>const</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_CANCELLED">CANCELLED</a>: u8 = 2;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_ACTIVE"></a>



<pre><code><b>const</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_ACTIVE">ACTIVE</a>: u8 = 0;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_FAILED"></a>



<pre><code><b>const</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_FAILED">FAILED</a>: u8 = 4;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_FILLED"></a>



<pre><code><b>const</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_FILLED">FILLED</a>: u8 = 1;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_LIMIT"></a>



<pre><code><b>const</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_LIMIT">LIMIT</a>: u8 = 1;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_LONG"></a>



<pre><code><b>const</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_LONG">LONG</a>: u8 = 0;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_MARKET"></a>



<pre><code><b>const</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_MARKET">MARKET</a>: u8 = 0;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_PARTIAL_FILLED"></a>



<pre><code><b>const</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_PARTIAL_FILLED">PARTIAL_FILLED</a>: u8 = 3;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_SHORT"></a>



<pre><code><b>const</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_SHORT">SHORT</a>: u8 = 1;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Market"></a>

## Function `Market`

Market Order


<pre><code><b>public</b> <b>fun</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Market">Market</a>(): u8
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Limit"></a>

## Function `Limit`

Limit Order


<pre><code><b>public</b> <b>fun</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Limit">Limit</a>(): u8
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Long"></a>

## Function `Long`

Long position


<pre><code><b>public</b> <b>fun</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Long">Long</a>(): u8
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Short"></a>

## Function `Short`

Short position


<pre><code><b>public</b> <b>fun</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Short">Short</a>(): u8
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Active"></a>

## Function `Active`

Order is currently finding settlers


<pre><code><b>public</b> <b>fun</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Active">Active</a>(): u8
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Filled"></a>

## Function `Filled`

Order has been filled


<pre><code><b>public</b> <b>fun</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Filled">Filled</a>(): u8
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Cancelled"></a>

## Function `Cancelled`

Order has been cancelled


<pre><code><b>public</b> <b>fun</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Cancelled">Cancelled</a>(): u8
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Partial"></a>

## Function `Partial`

Order has been partially filled - Only for flexible orders


<pre><code><b>public</b> <b>fun</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Partial">Partial</a>(): u8
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Failed"></a>

## Function `Failed`

Order failed to execute


<pre><code><b>public</b> <b>fun</b> <a href="constants.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_constants_Failed">Failed</a>(): u8
</code></pre>

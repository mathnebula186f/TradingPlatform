
<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin"></a>

# Module `0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9::dummy_coin`


* Dummy coin only for testing purposes


-  [Struct `DummyCoin`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin_DummyCoin)
-  [Function `init_module`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin_init_module)
-  [Function `mint`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin_mint)
-  [Function `register`](#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin_register)


<pre><code><b>use</b> <a href="">0x1::managed_coin</a>;
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin_DummyCoin"></a>

## Struct `DummyCoin`



<pre><code><b>struct</b> <a href="dummy_coin.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin_DummyCoin">DummyCoin</a>
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin_init_module"></a>

## Function `init_module`



<pre><code>entry <b>fun</b> <a href="dummy_coin.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin_init_module">init_module</a>(admin: &<a href="">signer</a>)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin_mint"></a>

## Function `mint`



<pre><code><b>public</b> entry <b>fun</b> <a href="dummy_coin.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin_mint">mint</a>(admin: &<a href="">signer</a>, destination: <b>address</b>, amount: u64)
</code></pre>



<a id="0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin_register"></a>

## Function `register`



<pre><code><b>public</b> entry <b>fun</b> <a href="dummy_coin.md#0x352b9127a0ffea9c45ad7faebc9ea88c2df5b2e35b1a5018d658159a135a2ef9_dummy_coin_register">register</a>(user: &<a href="">signer</a>)
</code></pre>

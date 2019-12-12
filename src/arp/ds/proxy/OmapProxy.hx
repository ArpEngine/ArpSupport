package arp.ds.proxy;

import arp.ds.access.IOmapAmend.IOmapAmendCursor;
import arp.ds.lambda.CollectionTools;
import arp.ds.IOmap;

class OmapProxy<K, V, X, W> implements IOmap<K, V> {

	private var omap:IOmap<X, W>;
	private var proxyKey:Null<Null<X>->Null<K>>;
	private var proxyValue:Null<Null<W>->Null<V>>;
	private var unproxyKey:Null<Null<K>->Null<X>>;
	private var unproxyValue:Null<Null<V>->Null<W>>;

	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return true;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new(
		omap:IOmap<X, W>,
		?proxyKey:Null<X>->Null<K>,
		?unproxyKey:Null<K>->Null<X>,
		?proxyValue:Null<W>->Null<V>,
		?unproxyValue:Null<V>->Null<W>
	) {
		this.omap = omap;
		this.proxyKey = proxyKey;
		this.unproxyKey = unproxyKey;
		this.proxyValue = proxyValue;
		this.unproxyValue = unproxyValue;
	}

	//read
	public function isEmpty():Bool return this.omap.isEmpty();
	public function hasValue(v:V):Bool return this.omap.hasValue(this.unproxyValue(v));
	public function iterator():Iterator<V> return new ProxyIterator(this.omap.iterator(), this.proxyValue);
	public function toString():String return CollectionTools.omapToStringImpl(this);
	public function get(k:K):Null<V> return this.proxyValue(this.omap.get(this.unproxyKey(k)));
	public function hasKey(k:K):Bool return this.omap.hasKey(this.unproxyKey(k));
	public function keys():Iterator<K> return new ProxyIterator(this.omap.keys(), this.proxyKey);
	public var length(get, never):Int;
	public function get_length():Int return this.omap.length;
	public function first():Null<V> return this.proxyValue(this.omap.first());
	public function last():Null<V> return this.proxyValue(this.omap.last());
	public function getAt(index:Int):Null<V> return this.proxyValue(this.omap.getAt(index));
	public function keyValueIterator():KeyValueIterator<K, V> return new ProxyKeyValueIterator(this.omap.keyValueIterator(), this.proxyKey, this.proxyValue);

	//resolve
	public function resolveKeyIndex(k:K):Int return this.omap.resolveKeyIndex(this.unproxyKey(k));
	public function resolveKeyAt(index:Int):Null<K> return this.proxyKey(this.omap.resolveKeyAt(index));
	public function resolveName(v:V):Null<K> return this.proxyKey(this.omap.resolveName(this.unproxyValue(v)));
	public function indexOf(v:V, ?fromIndex:Int):Int return this.omap.indexOf(this.unproxyValue(v), fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return this.omap.lastIndexOf(this.unproxyValue(v), fromIndex);

	//write
	public function addPair(k:K, v:V):Void this.omap.addPair(this.unproxyKey(k), this.unproxyValue(v));
	public function insertPairAt(index:Int, k:K, v:V):Void this.omap.insertPairAt(index, this.unproxyKey(k), this.unproxyValue(v));

	// remove
	public function remove(v:V):Bool return this.omap.remove(this.unproxyValue(v));
	public function removeKey(k:K):Bool return this.omap.removeKey(this.unproxyKey(k));
	public function removeAt(index:Int):Bool return this.omap.removeAt(index);
	public function pop():Null<V> return this.proxyValue(this.omap.pop());
	public function shift():Null<V> return this.proxyValue(this.omap.shift());
	public function clear():Void this.omap.clear();

	// amend
	public function amend():Iterator<IOmapAmendCursor<K, V>> return CollectionTools.omapAmendImpl(this);
}

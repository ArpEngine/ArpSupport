package arp.ds.proxy;

import arp.ds.access.IMapAmend.IMapAmendCursor;
import arp.ds.lambda.CollectionTools;
import arp.ds.IMap;

class MapProxy<K, V, X, W> implements IMap<K, V> {

	private var map:IMap<X, W>;
	private var proxyKey:Null<Null<X>->Null<K>>;
	private var proxyValue:Null<Null<W>->Null<V>>;
	private var unproxyKey:Null<Null<K>->Null<X>>;
	private var unproxyValue:Null<Null<V>->Null<W>>;

	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return true;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new(
		map:IMap<X, W>,
		?proxyKey:Null<X>->Null<K>,
		?unproxyKey:Null<K>->Null<X>,
		?proxyValue:Null<W>->Null<V>,
		?unproxyValue:Null<V>->Null<W>
	) {
		this.map = map;
		this.proxyKey = proxyKey;
		this.unproxyKey = unproxyKey;
		this.proxyValue = proxyValue;
		this.unproxyValue = unproxyValue;
	}

	//read
	public function isEmpty():Bool return this.map.isEmpty();
	public function hasValue(v:V):Bool return this.map.hasValue(this.unproxyValue(v));
	public function iterator():Iterator<V> return new ProxyIterator(this.map.iterator(), this.proxyValue);
	public function toString():String return CollectionTools.mapToStringImpl(this);
	public function get(k:K):Null<V> return this.proxyValue(this.map.get(this.unproxyKey(k)));
	public function hasKey(k:K):Bool return this.map.hasKey(this.unproxyKey(k));
	public function keys():Iterator<K> return new ProxyIterator(this.map.keys(), this.proxyKey);
	public function keyValueIterator():KeyValueIterator<K, V> return new ProxyKeyValueIterator(this.map.keyValueIterator(), this.proxyKey, this.proxyValue);

	//resolve
	public function resolveName(v:V):Null<K> return this.proxyKey(this.map.resolveName(this.unproxyValue(v)));

	//write
	public function set(k:K, v:V):Void this.map.set(this.unproxyKey(k), this.unproxyValue(v));

	//remove
	public function remove(v:V):Bool return this.map.remove(this.unproxyValue(v));
	public function removeKey(k:K):Bool return this.map.removeKey(this.unproxyKey(k));
	public function clear():Void this.map.clear();

	// amend
	public function amend():Iterator<IMapAmendCursor<K, V>> return CollectionTools.mapAmendImpl(this);
}

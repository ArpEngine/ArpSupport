package arp.ds.decorators;

import arp.ds.lambda.CollectionTools;
import arp.ds.access.IMapAmend.IMapAmendCursor;
import arp.ds.IMap;

class MapDecorator<K, V> implements IMap<K, V> {

	private var map:IMap<K, V>;
	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return this.map.isUniqueKey;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return this.map.isUniqueValue;

	public function new(map:IMap<K, V>) this.map = map;

	//read
	public function isEmpty():Bool return this.map.isEmpty();
	public function hasValue(v:V):Bool return this.map.hasValue(v);
	public function iterator():Iterator<V> return this.map.iterator();
	public function toString():String return this.map.toString();
	public function get(k:K):Null<V> return this.map.get(k);
	public function hasKey(k:K):Bool return this.map.hasKey(k);
	public function keys():Iterator<K> return this.map.keys();
	public function keyValueIterator():KeyValueIterator<K, V> return this.map.keyValueIterator();

	//resolve
	public function resolveName(v:V):Null<K> return this.map.resolveName(v);

	//write
	public function set(k:K, v:V):Void this.map.set(k, v);

	//remove
	public function remove(v:V):Bool return this.map.remove(v);
	public function removeKey(k:K):Bool return this.map.removeKey(k);
	public function clear():Void this.map.clear();

	//amend
	public function amend():Iterator<IMapAmendCursor<K, V>> return CollectionTools.mapAmendImpl(this);
}

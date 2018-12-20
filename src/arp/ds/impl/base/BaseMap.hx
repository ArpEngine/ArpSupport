package arp.ds.impl.base;

import arp.ds.access.IMapAmend.IMapAmendCursor;
import arp.ds.IMap;
import arp.ds.lambda.CollectionTools;

class BaseMap<K, V> implements IMap<K, V> {

	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return true;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new() return;

	//read
	public function isEmpty():Bool return CollectionTools.isEmptyImpl(this);
	public function hasValue(v:V):Bool return CollectionTools.hasValueImpl(this, v);
	public function iterator():Iterator<V> return CollectionTools.iteratorImpl(this);
	public function toString():String return CollectionTools.mapToStringImpl(this);
	public function get(k:K):Null<V> return CollectionTools.getImpl(this, k);
	public function hasKey(k:K):Bool return CollectionTools.hasKeyImpl(this, k);
	public function keys():Iterator<K> return CollectionTools.keysImpl(this);
	public function keyValueIterator():KeyValueIterator<K, V> return CollectionTools.keyValueIteratorImpl(this);

	//resolve
	public function resolveName(v:V):Null<K> return CollectionTools.resolveNameImpl(this, v);

	//write
	public function set(k:K, v:V):Void CollectionTools.setImpl(this, k, v);

	//remove
	public function remove(v:V):Bool return CollectionTools.removeImpl(this, v);
	public function removeKey(k:K):Bool return CollectionTools.removeKeyImpl(this, k);
	public function clear():Void CollectionTools.clearImpl(this);

	// amend
	public function amend():Iterator<IMapAmendCursor<K, V>> return CollectionTools.mapAmendImpl(this);
}

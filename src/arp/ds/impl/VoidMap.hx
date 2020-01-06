package arp.ds.impl;

import arp.ds.access.IMapAmend.IMapAmendCursor;
import arp.ds.IMap;
import arp.iterators.EmptyIterator;

class VoidMap<K, V> implements IMap<K, V> {

	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return true;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new() return;

	//read
	public function isEmpty():Bool return false;
	public function hasValue(v:V):Bool return false;
	public function iterator():Iterator<V> return new EmptyIterator();
	public function toString():String return "";
	public function get(k:K):Null<V> return null;
	public function hasKey(k:K):Bool return false;
	public function keys():Iterator<K> return new EmptyIterator();
	public function keyValueIterator():KeyValueIterator<K, V> return new EmptyIterator();

	//resolve
	public function keyOf(v:V):Null<K> return null;

	//write
	public function set(k:K, v:V):Void return;

	//remove
	public function remove(v:V):Bool return false;
	public function removeKey(k:K):Bool return false;
	public function clear():Void return;

	// amend
	public function amend():Iterator<IMapAmendCursor<K, V>> return new EmptyIterator();
}

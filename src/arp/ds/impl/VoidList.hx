package arp.ds.impl;

import arp.ds.access.IListAmend.IListAmendCursor;
import arp.ds.IList;
import arp.iterators.EmptyIterator;

class VoidList<V> implements IList<V> {

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new() return;

	//read
	public function isEmpty():Bool return false;
	public function hasValue(v:V):Bool return false;
	public function iterator():Iterator<V> return new EmptyIterator();
	public function toString():String return "";
	public var length(get, never):Int;
	public function get_length():Int return 0;
	public function first():Null<V> return null;
	public function last():Null<V> return null;
	public function getAt(index:Int):Null<V> return null;

	//resolve
	public function indexOf(v:V, ?fromIndex:Int):Int return -1;
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return -1;

	//write
	public function push(v:V):Int return 0;
	public function unshift(v:V):Void return;
	public function insertAt(index:Int, v:V):Void return;

	//remove
	public function pop():Null<V> return null;
	public function shift():Null<V> return null;
	public function remove(v:V):Bool return false;
	public function removeAt(index:Int):Bool return false;
	public function clear():Void return;

	// amend
	public function amend():Iterator<IListAmendCursor<V>> return new EmptyIterator();
	public function keyValueIterator():KeyValueIterator<Int, V> return new EmptyIterator();
}


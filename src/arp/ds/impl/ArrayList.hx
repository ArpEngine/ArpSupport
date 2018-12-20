package arp.ds.impl;

import arp.iterators.SimpleArrayIterator;
import arp.iterators.SimpleArrayKeyValueIterator;
import arp.ds.access.IListAmend.IListAmendCursor;
import arp.ds.IList;
import arp.ds.lambda.CollectionTools;

class ArrayList<V> implements IList<V> {

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	private var value:Array<V>;

	public function new() {
		this.value = [];
	}

	//read
	public function isEmpty():Bool return this.value.length == 0;
	public function hasValue(v:V):Bool return this.value.indexOf(v) >= 0;
	inline public function iterator():Iterator<V> return new SimpleArrayIterator(this.value);
	public function toString():String return CollectionTools.listToStringImpl(this);
	public var length(get, never):Int;
	public function get_length():Int return this.value.length;
	public function first():Null<V> return this.value[0];
	public function last():Null<V> return this.value[this.value.length - 1];
	public function getAt(index:Int):Null<V> return this.value[index];

	//resolve
	public function indexOf(v:V, ?fromIndex:Int):Int return this.value.indexOf(v, fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return this.value.lastIndexOf(v, fromIndex);

	//write
	public function push(v:V):Int return this.value.push(v);
	public function unshift(v:V):Void this.value.unshift(v);
	public function insertAt(index:Int, v:V):Void this.value.insert(index, v);

	//remove
	public function pop():Null<V> return this.value.pop();
	public function shift():Null<V> return this.value.shift();
	public function remove(v:V):Bool return this.value.remove(v);
	public function removeAt(index:Int):Bool return this.value.splice(index, 1).length > 0;
	public function clear():Void this.value = [];

	// amend
	public function amend():Iterator<IListAmendCursor<V>> return CollectionTools.listAmendImpl(this);
	inline public function keyValueIterator():KeyValueIterator<Int, V> return new SimpleArrayKeyValueIterator(this.value);
}

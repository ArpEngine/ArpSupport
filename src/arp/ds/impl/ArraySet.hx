package arp.ds.impl;

import arp.iterators.SimpleArrayIterator;
import arp.ds.access.ISetAmend.ISetAmendCursor;
import arp.ds.ISet;
import arp.ds.lambda.CollectionTools;

class ArraySet<V> implements ISet<V> {

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	private var value:Array<V>;

	public function new() {
		this.value = [];
	}

	//read
	public function isEmpty():Bool return this.value.length == 0;
	public function hasValue(v:V):Bool return this.value.indexOf(v) >= 0;
	inline public function iterator():Iterator<V> return new SimpleArrayIterator(this.value);
	public function toString():String return CollectionTools.setToStringImpl(this);

	//write
	public function add(v:V):Void if (this.value.indexOf(v) < 0) this.value.push(v);

	//remove
	public function remove(v:V):Bool return this.value.remove(v);
	public function clear():Void this.value = [];

	// amend
	public function amend():Iterator<ISetAmendCursor<V>> return CollectionTools.setAmendImpl(this);
}

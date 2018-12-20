package arp.ds.impl;

import arp.ds.access.ISetAmend.ISetAmendCursor;
import arp.ds.ISet;
import arp.ds.lambda.CollectionTools;

@:generic @:remove
class StdMapSet<V> implements ISet<V> {

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	private var value:Map<V, Bool>;

	public function new() {
		this.value = new Map();
	}

	//read
	public function isEmpty():Bool return !this.value.iterator().hasNext();
	public function hasValue(v:V):Bool return this.value.exists(v);
	inline public function iterator():Iterator<V> return this.value.keys();
	public function toString():String return CollectionTools.setToStringImpl(this);

	//write
	public function add(v:V):Void this.value.set(v, true);

	//remove
	public function remove(v:V):Bool return this.value.remove(v);
	public function clear():Void this.value = new Map();

	// amend
	public function amend():Iterator<ISetAmendCursor<V>> return CollectionTools.setAmendImpl(this);
}

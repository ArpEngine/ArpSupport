package arp.ds.impl;

import arp.iterators.SimpleArrayIterator;
import arp.iterators.SimpleArrayIterator;
import arp.ds.access.IOmapAmend.IOmapAmendCursor;
import arp.ds.IOmap;
import arp.ds.lambda.CollectionTools;

@:generic @:remove
class StdOmap<K, V> implements IOmap<K, V> {

	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return true;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	private var _keys:Array<K>;
	private var value:Map<K, V>;

	public function new() {
		this._keys = [];
		this.value = new Map();
	}

	//read
	public function isEmpty():Bool return !this.value.iterator().hasNext();
	public function hasValue(v:V):Bool { for (x in this.value) if (x == v) return true; return false; }
	inline public function iterator():Iterator<V> return new StdOmapValueIterator(this._keys, this.value);
	public function toString():String return CollectionTools.omapToStringImpl(this);
	public function get(k:K):Null<V> return this.value.get(k);
	public function hasKey(k:K):Bool return this.value.exists(k);
	inline public function keys():Iterator<K> return new SimpleArrayIterator(this._keys);
	public var length(get, never):Int;
	public function get_length():Int return this._keys.length;
	public function first():Null<V> return this.get(this._keys[0]);
	public function last():Null<V> return this.get(this._keys[this._keys.length - 1]);
	public function getAt(index:Int):Null<V> return this.get(this._keys[index]);
	inline public function keyValueIterator():KeyValueIterator<K, V> return new StdOmapKeyValueIterator(this._keys, this.value);

	//resolve
	public function resolveKeyIndex(k:K):Int return this._keys.indexOf(k);
	public function resolveName(v:V):Null<K> {
		for (k in this.value.keys()) if (this.value.get(k) == v) return k;
		return null;
	}
	public function indexOf(v:V, ?fromIndex:Int):Int {
		var i:Int = 0; for (k in this._keys) if (this.value.get(k) == v) return i; else i++; return -1;
	}
	public function lastIndexOf(v:V, ?fromIndex:Int):Int {
		var i:Int = 0; var index:Int = -1; for (k in this._keys) if (this.value.get(k) == v) index = i++; else i++; return index;
	}

	//write
	public function addPair(k:K, v:V):Void {
		if (this._keys.indexOf(k) < 0) this._keys.push(k);
		this.value.set(k, v);
	}
	public function insertPairAt(index:Int, k:K, v:V):Void {
		if (this._keys.indexOf(k) >= 0) this._keys.splice(index, 1);
		this._keys.insert(index, k);
		this.value.set(k, v);
	}

	//remove
	public function remove(v:V):Bool return this._removeAt(this.indexOf(v));
	public function removeKey(k:K):Bool return this._removeAt(this.resolveKeyIndex(k));
	public function removeAt(index:Int):Bool return this._removeAt(index);
	public function pop():Null<V> return this._removeAtValue(this._keys.length - 1);
	public function shift():Null<V> return this._removeAtValue(0);
	public function clear():Void {
		this._keys = [];
		this.value = new Map();
	}

	inline private function _removeAt(index:Int):Bool {
		if (index < 0) return false;
		var k:K = this._keys.splice(index, 1)[0];
		var v:V = this.value.get(k);
		return this.value.remove(k);
	}

	inline private function _removeAtValue(index:Int):Null<V> {
		if (index < 0) return null;
		var k:K = this._keys.splice(index, 1)[0];
		var v:V = this.value.get(k);
		this.value.remove(k);
		return v;
	}

	// amend
	public function amend():Iterator<IOmapAmendCursor<K, V>> return CollectionTools.omapAmendImpl(this);
}

@:generic @:remove
private class StdOmapValueIterator<K, V> {

	private var iterator:Iterator<K>;
	private var value:Map<K, V>;

	inline public function new(keys:Array<K>, value:Map<K, V>) {
		this.iterator = new SimpleArrayIterator(keys);
		this.value = value;
	}

	inline public function hasNext():Bool {
		return this.iterator.hasNext();
	}

	inline public function next():Null<V> {
		return this.value.get(this.iterator.next());
	}
}

@:generic @:remove
private class StdOmapKeyValueIterator<K, V> {

	private var iterator:Iterator<K>;
	private var value:Map<K, V>;

	inline public function new(keys:Array<K>, value:Map<K, V>) {
		this.iterator = new SimpleArrayIterator(keys);
		this.value = value;
	}

	inline public function hasNext():Bool {
		return this.iterator.hasNext();
	}

	inline public function next():{ key: K, value: Null<V> } {
		var key:K = this.iterator.next();
		return { key: key, value: this.value.get(key)};
	}
}

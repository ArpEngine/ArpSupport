package arp.ds.lambda.cursors;

import arp.ds.access.IMapAmend.IMapAmendCursor;

class ArrayMapAmendCursor<K, V> implements IMapAmendCursor<K, V> {

	private var me:IMap<K, V>;
	private var keys:Array<K>;
	private var readIndex:Int;
	private var removedIndex:Int;

	inline public function new(me:IMap<K, V>) {
		this.me = me;
		this.keys = MapOp.toKeyArray(me);
		this.readIndex = -1;
		this.removedIndex = -1;
	}

	inline public function hasNext():Bool return readIndex + 1 < keys.length;
	inline public function next():IMapAmendCursor<K, V> { readIndex++; return this; }

	public var key(get, never):K;
	inline private function get_key():K return keys[readIndex];
	public var value(get, never):V;
	inline private function get_value():V return me.get(keys[readIndex]);

	inline public function insert(k:K, v:V):Void me.set(k, v);
	inline public function remove():Bool {
		if (removedIndex == readIndex) throw "invalid operation";
		removedIndex = readIndex;
		return me.removeKey(key);
	}
}

package arp.ds.lambda.cursors;

import arp.ds.access.IOmapAmend.IOmapAmendCursor;

class ArrayOmapAmendCursor<K, V> implements IOmapAmendCursor<K, V> {

	private var me:IOmap<K, V>;
	private var keys:Array<K>;
	private var readIndex:Int;
	private var outIndex:Int;
	private var removedIndex:Int;

	inline public function new(me:IOmap<K, V>) {
		this.me = me;
		this.keys = OmapOp.toKeyArray(me);
		this.readIndex = -1;
		this.outIndex = -1;
		this.removedIndex = -1;
	}

	inline public function hasNext():Bool return readIndex + 1 < keys.length;
	inline public function next():IOmapAmendCursor<K, V> { readIndex++; outIndex++; return this; }

	public var key(get, never):K;
	inline private function get_key():K return keys[readIndex];
	public var value(get, never):V;
	inline private function get_value():V return me.get(keys[readIndex]);
	public var index(get, never):Int;
	inline private function get_index():Int return readIndex;

	inline public function prepend(k:K, v:V):Void me.insertPairAt(outIndex++, k, v);
	inline public function append(k:K, v:V):Void me.insertPairAt(++outIndex, k, v);
	inline public function remove():Bool {
		if (removedIndex == readIndex) throw "invalid operation";
		removedIndex = readIndex;
		return me.removeAt(outIndex--);
	}
}

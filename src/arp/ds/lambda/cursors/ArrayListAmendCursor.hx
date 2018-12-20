package arp.ds.lambda.cursors;

import arp.ds.access.IListAmend.IListAmendCursor;

class ArrayListAmendCursor<V> implements IListAmendCursor<V> {

	private var me:IList<V>;
	private var values:Array<V>;
	private var readIndex:Int;
	private var outIndex:Int;
	private var removedIndex:Int;

	inline public function new(me:IList<V>) {
		this.me = me;
		this.values = ListOp.toArray(me);
		this.readIndex = -1;
		this.outIndex = -1;
		this.removedIndex = -1;
	}

	inline public function hasNext():Bool return readIndex + 1 < values.length;
	inline public function next():IListAmendCursor<V> { readIndex++; outIndex++; return this; }

	public var value(get, never):V;
	inline private function get_value():V return values[readIndex];
	public var index(get, never):Int;
	inline private function get_index():Int return readIndex;

	inline public function prepend(v:V):Void me.insertAt(outIndex++, v);
	inline public function append(v:V):Void me.insertAt(++outIndex, v);
	inline public function remove():Bool {
		if (removedIndex == readIndex) throw "invalid operation";
		removedIndex = readIndex;
		return me.removeAt(outIndex--);
	}
}

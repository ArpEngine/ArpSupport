package arp.ds.lambda.cursors;

import arp.ds.access.ISetAmend.ISetAmendCursor;

class ArraySetAmendCursor<V> implements ISetAmendCursor<V> {

	private var me:ISet<V>;
	private var values:Array<V>;
	private var readIndex:Int;
	private var removedIndex:Int;

	inline public function new(me:ISet<V>) {
		this.me = me;
		this.values = SetOp.toArray(me);
		this.readIndex = -1;
		this.removedIndex = -1;
	}

	inline public function hasNext():Bool return readIndex + 1 < values.length;
	inline public function next():ISetAmendCursor<V> { readIndex++; return this; }

	public var value(get, never):V;
	inline private function get_value():V return values[readIndex];

	inline public function insert(v:V):Void me.add(v);
	inline public function remove():Bool {
		if (removedIndex == readIndex) throw "invalid operation";
		removedIndex = readIndex;
		return me.remove(this.value);
	}
}

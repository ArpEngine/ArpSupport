package arp.ds.lambda.iterators;

class ListKeyValueIterator<V> {

	public var key(default, default):Int;
	public var value(default, default):V;

	private var me:IList<V>;
	private var keyIterator:IntIterator;

	inline public function new(me:IList<V>) {
		this.me = me;
		this.keyIterator = new IntIterator(0, me.length);
	}

	inline public function hasNext():Bool return this.keyIterator.hasNext();
	inline public function next():ListKeyValueIterator<V> { this.keyIterator.next(); return this; }
}

package arp.ds.lambda.iterators;

import arp.ds.access.IOmapAmend.IOmapAmendCursor;

class OmapIndexValueIterator<K, V> {

	public var key(default, default):Int;
	public var value(default, default):V;

	private var me:IOmap<K, V>;
	private var iterator:Iterator<IOmapAmendCursor<K, V>>;

	inline public function new(me:IOmap<K, V>) {
		this.me = me;
		this.iterator = me.amend();
	}

	inline public function hasNext():Bool return this.iterator.hasNext();
	inline public function next():OmapIndexValueIterator<K, V> {
		var cursor = this.iterator.next();
		this.key = cursor.index;
		this.value = cursor.value;
		return this;
	}
}

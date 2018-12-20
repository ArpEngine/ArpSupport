package arp.ds.lambda.iterators;

class MapKeyValueIterator<K, V> {

	public var key(default, default):K;
	public var value(default, default):V;

	private var me:IMap<K, V>;
	private var keyIterator:Iterator<K>;

	inline public function new(me:IMap<K, V>) {
		this.me = me;
		this.keyIterator = me.keys();
	}

	inline public function hasNext():Bool return this.keyIterator.hasNext();
	inline public function next():MapKeyValueIterator<K, V> { this.key = this.keyIterator.next(); this.value = me.get(this.key); return this; }
}

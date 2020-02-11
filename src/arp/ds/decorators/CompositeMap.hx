package arp.ds.decorators;

import arp.ds.access.IMapRead;
import arp.ds.access.IMapResolve;
import arp.ds.IMap;

class CompositeMap<K, V> implements IMapRead<K, V> implements IMapResolve<K, V> {

	private var maps:Array<IMap<K, V>>;

	public function new(map:IMap<K, V>, maps:Array<IMap<K, V>>) {
		super();
		this.maps = maps;
	}

	//read
	public function isEmpty():Bool return this.map.isEmpty();
	public function hasValue(v:V):Bool return this.map.hasValue(v);
	public function iterator():Iterator<V> return this.map.iterator();
	public function toString():String return this.map.toString();
	public function get(k:K):Null<V> return this.map.get(k);
	public function hasKey(k:K):Bool return this.map.hasKey(k);
	public function keys():Iterator<K> return this.map.keys();
	public function keyValueIterator():KeyValueIterator<K, V> return this.map.keyValueIterator();

	//resolve
	public function keyOf(v:V):Null<K> return this.map.keyOf(v);
}

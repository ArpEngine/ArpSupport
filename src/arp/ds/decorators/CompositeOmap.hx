package arp.ds.decorators;

import arp.ds.access.IOmapRead;
import arp.ds.access.IOmapResolve;
import arp.ds.IOmap;

class CompositeOmap<K, V> implements IOmapRead<K, V> implements IOmapResolve<K, V> {

	private var omaps:Array<IOmap<K, V>>;

	public function new(omap:IOmap<K, V>, omaps:Array<IOmap<K, V>>) {
		super(omap);
		this.omaps = omaps;
	}

	//read
	public function isEmpty():Bool return this.omap.isEmpty();
	public function hasValue(v:V):Bool return this.omap.hasValue(v);
	public function iterator():Iterator<V> return this.omap.iterator();
	public function toString():String return this.omap.toString();
	public function get(k:K):Null<V> return this.omap.get(k);
	public function hasKey(k:K):Bool return this.omap.hasKey(k);
	public function keys():Iterator<K> return this.omap.keys();
	public var length(get, never):Int;
	public function get_length():Int return this.omap.length;
	public function first():Null<V> return this.omap.first();
	public function last():Null<V> return this.omap.last();
	public function getAt(index:Int):Null<V> return this.omap.getAt(index);
	public function keyValueIterator():KeyValueIterator<K, V> return this.omap.keyValueIterator();

	//resolve
	public function resolveKeyIndex(k:K):Int return this.omap.resolveKeyIndex(k);
	public function resolveKeyAt(index:Int):Null<K> return this.omap.resolveKeyAt(index);
	public function keyOf(v:V):Null<K> return this.omap.keyOf(v);
	public function indexOf(v:V, ?fromIndex:Int):Int return this.omap.indexOf(v, fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return this.omap.lastIndexOf(v, fromIndex);


package arp.ds.decorators;

import arp.ds.lambda.CollectionTools;
import arp.ds.access.IOmapAmend.IOmapAmendCursor;
import arp.ds.IOmap;

class OmapDecorator<K, V> implements IOmap<K, V> {

	private var omap:IOmap<K, V>;

	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return this.omap.isUniqueKey;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return this.omap.isUniqueValue;

	public function new(omap:IOmap<K, V>) this.omap = omap;

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
	public function resolveName(v:V):Null<K> return this.omap.resolveName(v);
	public function indexOf(v:V, ?fromIndex:Int):Int return this.omap.indexOf(v, fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return this.omap.lastIndexOf(v, fromIndex);

	//write
	public function addPair(k:K, v:V):Void this.omap.addPair(k, v);
	public function insertPairAt(index:Int, k:K, v:V):Void this.omap.insertPairAt(index, k, v);

	// remove
	public function remove(v:V):Bool return this.omap.remove(v);
	public function removeKey(k:K):Bool return this.omap.removeKey(k);
	public function removeAt(index:Int):Bool return this.omap.removeAt(index);
	public function pop():Null<V> return this.omap.pop();
	public function shift():Null<V> return this.omap.shift();
	public function clear():Void this.omap.clear();

	//amend
	public function amend():Iterator<IOmapAmendCursor<K, V>> return CollectionTools.omapAmendImpl(this);
}

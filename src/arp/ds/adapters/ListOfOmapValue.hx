package arp.ds.adapters;

import arp.ds.lambda.iterators.OmapIndexValueIterator;
import arp.ds.access.IListAmend.IListAmendCursor;
import arp.ds.lambda.CollectionTools;
import arp.ds.IList;
import arp.ds.IOmap;

class ListOfOmapValue<K, V> implements IList<V> {

	private var omap:IOmap<K, V>;
	private var autoKey:V->K;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new(omap:IOmap<K, V>, autoKey:V->K) {
		this.omap = omap;
		this.autoKey = autoKey;
	}

	public function isEmpty():Bool return this.omap.isEmpty();
	public function hasValue(v:V):Bool return this.omap.hasValue(v);
	public function iterator():Iterator<V> return this.omap.iterator();
	public function toString():String return CollectionTools.listToStringImpl(this);
	public var length(get, never):Int;
	public function get_length():Int return this.omap.length;
	public function first():Null<V> return this.omap.first();
	public function last():Null<V> return this.omap.last();
	public function getAt(index:Int):Null<V> return this.omap.getAt(index);

	//resolve
	public function indexOf(v:V, ?fromIndex:Int):Int return this.omap.indexOf(v, fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return this.omap.lastIndexOf(v, fromIndex);

	//write
	public function push(v:V):Int {
		this.omap.addPair(this.autoKey(v), v);
		return this.omap.length;
	}
	public function unshift(v:V):Void this.omap.insertPairAt(0, this.autoKey(v), v);
	public function insertAt(index:Int, v:V):Void this.omap.insertPairAt(index, this.autoKey(v), v);

	//remove
	public function pop():Null<V> return this.omap.pop();
	public function shift():Null<V> return this.omap.shift();
	public function remove(v:V):Bool return this.omap.remove(v);
	public function removeAt(index:Int):Bool return this.omap.removeAt(index);
	public function clear():Void this.omap.clear();

	//amend
	public function amend():Iterator<IListAmendCursor<V>> return CollectionTools.listAmendImpl(this);
	inline public function keyValueIterator():KeyValueIterator<Int, V> return new OmapIndexValueIterator(this.omap);
}

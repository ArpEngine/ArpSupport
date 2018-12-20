package arp.ds.proxy;

import arp.ds.access.IListAmend.IListAmendCursor;
import arp.ds.lambda.CollectionTools;
import arp.ds.IList;

class ListProxy<V, W> implements IList<V> {

	private var list:IList<W>;
	private var proxyValue:Null<Null<W>->Null<V>>;
	private var unproxyValue:Null<Null<V>->Null<W>>;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new(
		list:IList<W>,
		?proxyValue:Null<W>->Null<V>,
		?unproxyValue:Null<V>->Null<W>
	) {
		this.list = list;
		this.proxyValue = proxyValue;
		this.unproxyValue = unproxyValue;
	}

	//read
	public function isEmpty():Bool return this.list.isEmpty();
	public function hasValue(v:V):Bool return this.list.hasValue(this.unproxyValue(v));
	public function iterator():Iterator<V> return new ProxyIterator(this.list.iterator(), this.proxyValue);
	public function toString():String return CollectionTools.listToStringImpl(this);
	public var length(get, never):Int;
	public function get_length():Int return this.list.length;
	public function first():Null<V> return this.proxyValue(this.list.first());
	public function last():Null<V> return this.proxyValue(this.list.last());
	public function getAt(index:Int):Null<V> return this.proxyValue(this.list.getAt(index));

	//resolve
	public function indexOf(v:V, ?fromIndex:Int):Int return this.list.indexOf(this.unproxyValue(v), fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return this.list.lastIndexOf(this.unproxyValue(v), fromIndex);

	//write
	public function push(v:V):Int return this.list.push(this.unproxyValue(v));
	public function unshift(v:V):Void this.list.unshift(this.unproxyValue(v));
	public function insertAt(index:Int, v:V):Void this.list.insertAt(index, this.unproxyValue(v));

	//remove
	public function pop():Null<V> return this.proxyValue(this.list.pop());
	public function shift():Null<V> return this.proxyValue(this.list.shift());
	public function remove(v:V):Bool return this.list.remove(this.unproxyValue(v));
	public function removeAt(index:Int):Bool return this.list.removeAt(index);
	public function clear():Void this.list.clear();

	// amend
	public function amend():Iterator<IListAmendCursor<V>> return CollectionTools.listAmendImpl(this);
	public function keyValueIterator():KeyValueIterator<Int, V> return new ProxyKeyValueIterator(this.list.keyValueIterator(), k -> k,  this.proxyValue);
}

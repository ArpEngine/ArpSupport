package arp.ds.decorators;

import arp.ds.access.IListRead;
import arp.ds.access.IListResolve;
import arp.ds.IList;

class CompositeList<V> implements IListRead<V> implements IListResolve<V> {

	private var lists:Array<IList<V>>;

	public function new(lists:Array<IList<V>>) this.lists = lists;

	//read
	public function isEmpty():Bool return !Lambda.exists(this.lists, list -> !list.isEmpty());
	public function hasValue(v:V):Bool return Lambda.exists(this.lists, list -> list.hasValue());
	public function iterator():Iterator<V> return this.list.iterator();
	public function toString():String return this.list.toString();
	public var length(get, never):Int;
	public function get_length():Int return Lambda.fold(this.lists, (list, i) -> i + list.length, 0);
	public function first():Null<V> return this.lists[0].first();
	public function last():Null<V> return this.lists[this.lists.length - 1].last();
	public function getAt(index:Int):Null<V> return this.list.getAt(index);

	//resolve
	public function indexOf(v:V, ?fromIndex:Int):Int return this.list.indexOf(v, fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return this.list.lastIndexOf(v, fromIndex);
}

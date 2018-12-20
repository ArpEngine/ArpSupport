package arp.ds.access;

interface IListRemove<V> extends ICollectionRemove<V> extends IListRead<V> {
	function pop():Null<V>;
	function shift():Null<V>;
	function removeAt(index:Int):Bool;
}

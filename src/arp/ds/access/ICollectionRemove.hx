package arp.ds.access;

interface ICollectionRemove<V> extends ICollectionRead<V> {
	function remove(v:V):Bool;
	function clear():Void;
}

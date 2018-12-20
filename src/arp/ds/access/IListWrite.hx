package arp.ds.access;

interface IListWrite<V> extends ICollectionWrite<V> {
	function push(v:V):Int;
	function unshift(v:V):Void;
	function insertAt(index:Int, v:V):Void;
}

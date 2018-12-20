package arp.ds.access;

interface IListResolve<V> extends IListRead<V> {
	function indexOf(v:V, ?fromIndex:Int):Int;
	function lastIndexOf(v:V, ?fromIndex:Int):Int;
}

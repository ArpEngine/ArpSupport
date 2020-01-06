package arp.ds.access;

interface IMapResolve<K, V> extends IMapRead<K, V> {
	function keyOf(v:V):Null<K>;
}

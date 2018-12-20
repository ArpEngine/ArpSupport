package arp.ds.access;

interface IMapResolve<K, V> extends IMapRead<K, V> {
	function resolveName(v:V):Null<K>;
}

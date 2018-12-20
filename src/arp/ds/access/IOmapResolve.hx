package arp.ds.access;

interface IOmapResolve<K, V> extends IOmapRead<K, V> extends IMapResolve<K, V>  extends IListResolve<V> {
	function resolveKeyIndex(k:K):Int;
}

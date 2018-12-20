package arp.ds.access;

interface IMapRemove<K, V> extends ICollectionRemove<V> extends IMapRead<K, V> {
	function removeKey(k:K):Bool;
}

package arp.ds.access;

interface IMapWrite<K, V> extends ICollectionWrite<K> {
	function set(k:K, v:V):Void;
}

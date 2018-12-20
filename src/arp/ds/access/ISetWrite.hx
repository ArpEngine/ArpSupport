package arp.ds.access;

interface ISetWrite<V> extends ICollectionWrite<V> {
	function add(v:V):Void;
}

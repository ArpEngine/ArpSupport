package arp.ds.access;

interface IMapRead<K, V> extends ICollectionRead<V> {
	var isUniqueKey(get, never):Bool;
	function get_isUniqueKey():Bool;

	function get(k:K):Null<V>;
	function hasKey(k:K):Bool;
	function keys():Iterator<K>;
	function keyValueIterator():KeyValueIterator<K, V>;
}

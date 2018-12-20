package arp.ds.access;

interface IMapAmend<K, V> extends IMapRead<K, V> {
	function amend():Iterator<IMapAmendCursor<K, V>>;
}

interface IMapAmendCursor<K, V> {
	var key(get, never):K;
	var value(get, never):V;

	function insert(k:K, v:V):Void;
	function remove():Bool;
}

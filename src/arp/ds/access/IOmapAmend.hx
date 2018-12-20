package arp.ds.access;

interface IOmapAmend<K, V> extends IOmapRead<K, V> {
	function amend():Iterator<IOmapAmendCursor<K, V>>;
}

interface IOmapAmendCursor<K, V> {
	var index(get, never):Int;
	var key(get, never):K;
	var value(get, never):V;

	function prepend(k:K, v:V):Void;
	function append(k:K, v:V):Void;
	function remove():Bool;
}

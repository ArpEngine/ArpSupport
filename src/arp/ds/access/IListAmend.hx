package arp.ds.access;

interface IListAmend<V> extends IListRead<V> {
	function amend():Iterator<IListAmendCursor<V>>;
	function keyValueIterator():KeyValueIterator<Int, V>;
}

interface IListAmendCursor<V> {
	var index(get, never):Int;
	var value(get, never):V;

	function prepend(v:V):Void;
	function append(v:V):Void;
	function remove():Bool;
}

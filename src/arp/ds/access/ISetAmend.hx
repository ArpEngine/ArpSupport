package arp.ds.access;

interface ISetAmend<V> extends ISetRead<V> {
	function amend():Iterator<ISetAmendCursor<V>>;
}

interface ISetAmendCursor<V> {
	var value(get, never):V;

	function insert(v:V):Void;
	function remove():Bool;
}

package arp.ds.access;

interface ICollectionRead<V> {
	var isUniqueValue(get, never):Bool;
	function get_isUniqueValue():Bool;

	function isEmpty():Bool;
	function hasValue(v:V):Bool;
	function iterator():Iterator<V>;
	function toString():String;
}

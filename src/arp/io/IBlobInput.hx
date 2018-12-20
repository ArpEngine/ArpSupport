package arp.io;

import haxe.io.Bytes;

interface IBlobInput {
	var bigEndian(get, set):Bool;
	function flush():Void;
	function nextUtfBlob():Null<String>;
	function nextBlob():Null<Bytes>;
}


package arp.io;

import haxe.io.Bytes;

interface IBlobOutput {
	var bigEndian(get, set):Bool;
	function writeBlob(value:Bytes):Void;
	function writeUtfBlob(value:String):Void;
}

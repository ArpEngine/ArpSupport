package arp.io;

import haxe.io.Bytes;

interface IInput {
	var bigEndian(get, set):Bool;

	function readBool():Bool;

	function readInt8():Int;
	function readInt16():Int;
	function readInt32():Int;

	function readUInt8():UInt;
	function readUInt16():UInt;
	function readUInt32():UInt;

	function readFloat():Float;
	function readDouble():Float;

	function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void;
	function readUtfBytes(length:UInt):String;

	function readBlob():Bytes;
	function readUtfBlob():String;

	function readUtfString():Null<String>;

	function nextBytes(limit:Int = 0):Bytes;
}


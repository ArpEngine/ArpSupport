package arp.io;

import haxe.io.Bytes;

interface IOutput {
	var bigEndian(get, set):Bool;

	function writeBool(value:Bool):Void;

	function writeInt8(value:Int):Void;
	function writeInt16(value:Int):Void;
	function writeInt32(value:Int):Void;

	function writeUInt8(value:UInt):Void;
	function writeUInt16(value:UInt):Void;
	function writeUInt32(value:UInt):Void;

	function writeFloat(value:Float):Void;
	function writeDouble(value:Float):Void;

	function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void;
	function writeUtfBytes(value:String):Void;

	function writeBlob(value:Bytes):Void;
	function writeUtfBlob(value:String):Void;

	function writeUtfString(value:Null<String>):Void;
}


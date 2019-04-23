package arp.persistable;

import haxe.io.Bytes;

interface IPersistOutput {

	var persistLevel(get, never):Int;

	function writeEnter(name:String):Void;
	function writeListEnter(name:String):Void;
	function writeExit():Void;
	function writeScope(name:String, body:IPersistOutput->Void):Void;
	function writeListScope(name:String, body:IPersistOutput->Void):Void;

	function writeNameList(name:String, value:Array<String>):Void;
	function writePersistable(name:String, value:IPersistable):Void;

	function writeBool(name:String, value:Bool):Void;
	function writeInt32(name:String, value:Int):Void;
	function writeUInt32(name:String, value:UInt):Void;
	function writeDouble(name:String, value:Float):Void;

	function writeUtf(name:String, value:String):Void;
	function writeBlob(name:String, bytes:Bytes):Void;

	function pushBool(value:Bool):Void;
	function pushInt32(value:Int):Void;
	function pushUInt32(value:UInt):Void;
	function pushDouble(value:Float):Void;

	function pushUtf(value:String):Void;
	function pushBlob(bytes:Bytes):Void;
}


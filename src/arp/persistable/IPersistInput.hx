package arp.persistable;

import haxe.io.Bytes;

interface IPersistInput {

	var persistLevel(get, never):Int;

	function readEnter(name:String):Void;
	function readListEnter(name:String):Void;
	function readExit():Void;
	function readScope(name:String, body:IPersistInput->Void):Void;
	function readListScope(name:String, body:IPersistInput->Void):Void;

	function readNameList(name:String):Array<String>;
	function readPersistable<T:IPersistable>(name:String, persistable:T):T;

	function readBool(name:String):Bool;
	function readInt32(name:String):Int;
	function readUInt32(name:String):UInt;
	function readDouble(name:String):Float;

	function readUtf(name:String):String;
	function readBlob(name:String):Bytes;

	function nextBool():Bool;
	function nextInt32():Int;
	function nextUInt32():UInt;
	function nextDouble():Float;

	function nextUtf():String;
	function nextBlob():Bytes;
}


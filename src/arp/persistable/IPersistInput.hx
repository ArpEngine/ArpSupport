package arp.persistable;

import haxe.io.Bytes;

interface IPersistInput {

	var persistLevel(get, never):Int;

	function readEnter(name:String):Void;
	function readListEnter(name:String):Void;
	function nextEnter():Void;
	function nextListEnter():Void;
	function readExit():Void;

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

	function readPersistable<T:IPersistable>(name:String, persistable:T):T;
	function nextPersistable<T:IPersistable>(persistable:T):T;
	function readScope(name:String, body:IPersistInput->Void):Void;
	function readListScope(name:String, body:IPersistInput->Void):Void;
}

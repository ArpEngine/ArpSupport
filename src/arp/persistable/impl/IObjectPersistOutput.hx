package arp.persistable.impl;

interface IObjectPersistOutput extends IPersistOutput {

	function pushState(data:Dynamic):Void;
	function popState():Bool;

	function writeAny(name:String, value:Dynamic):Void;
	function pushAny(value:Dynamic):Void;
}


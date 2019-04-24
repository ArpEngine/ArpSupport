package arp.persistable.impl;

interface IObjectPersistOutput extends IPersistOutput {

	function writeAny(name:String, value:Dynamic):Void;
	function pushAny(value:Dynamic):Void;
}


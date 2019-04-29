package arp.persistable.impl;

interface IObjectPersistInput extends IPersistInput {

	function pushState(data:Dynamic):Void;
	function popState():Bool;

	function readAny(name:String):Dynamic;
	function nextAny():Dynamic;
}


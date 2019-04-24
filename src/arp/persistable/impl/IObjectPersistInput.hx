package arp.persistable.impl;

interface IObjectPersistInput extends IPersistInput {

	function readAny(name:String):Dynamic;
	function nextAny():Dynamic;
}


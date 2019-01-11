package arp.events;

interface IArpSignalOut<T> {

	function push(handler:T->Void):Int;
	function prepend(handler:T->Void):Int;
	function append(handler:T->Void):Int;
	function remove(handler:T->Void):Bool;
	function flush():Void;

}

package arp.events;

interface IArpSignalIn<T> {

	function willTrigger():Bool;
	function dispatch(event:T):Void;
	function dispatchLazy(event:Void->T):Void;

}

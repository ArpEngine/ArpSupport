package arp.task;
interface ITickableElement<T, T2> {
	function tickElement(timeslice:Float, parent:T, root:T2):Bool;
}

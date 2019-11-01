package arp.task;
interface ITickableChild<T> {
	function tickChild(timeslice:Float, parent:T):Heartbeat;
}

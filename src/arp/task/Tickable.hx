package arp.task;

class Tickable implements ITickable {
	public function new(tick:(timeslice:Float)->Bool) this._tick = tick;
	private dynamic function _tick(timeslice:Float):Bool return false;
	inline public function tick(timeslice:Float):Bool return this._tick(timeslice);
}

package arp.task;

class Tickable implements ITickable {
	public function new(tick:(timeslice:Float)->Heartbeat) this._tick = tick;
	private dynamic function _tick(timeslice:Float):Heartbeat return Heartbeat.Destroy;
	inline public function tick(timeslice:Float):Heartbeat return this._tick(timeslice);
}

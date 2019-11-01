package arp.task;

enum abstract Heartbeat(Bool) {
	var Keep = true;
	var Destroy = false;

	inline public static function keepIf(value:Bool) return cast value;
	inline public function isKeep():Bool return this;
}

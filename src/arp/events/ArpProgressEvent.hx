package arp.events;

class ArpProgressEvent {

	public var progress:Float;
	public var total:Float;

	public function new(progress:Float, total:Float) {
		this.progress = progress;
		this.total = total;
	}

}

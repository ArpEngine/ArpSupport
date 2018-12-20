package arp.iterators;

class StepIterator<T:Float> {

	private var current:T;
	private var to:T;
	private var step:T;

	inline public function new(from:T, to:T, step:T) {
		this.current = from;
		this.to = to;
		this.step = step;
	}

	inline public function hasNext():Bool {
		if (this.step < 0) {
			return this.current > this.to;
		} else {
			return this.current < this.to;
		}
	}

	inline public function next():T {
		var value:T = this.current;
		this.current += this.step;
		return value;
	}
}

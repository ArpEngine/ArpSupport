package arp.iterators;

class CompositeIterator<T> {

	private var iterators:Iterator<Iterable<T>>;
	private var iterator:Iterator<T>;

	inline public function new(iterable:Iterable<Iterable<T>>) {
		this.iterators = iterable.iterator();
		if (this.iterators.hasNext()) this.slurp();
	}

	inline public function hasNext():Bool return this.iterators.hasNext();

	inline public function next():T {
		if (this.iterator.hasNext()) {
			var t = this.iterator.next();
			this.slurp();
			return t;
		} else {
			// undefined behaviour
			return cast null;
		}
	}

	inline private function slurp():Void {
		while (!this.iterator.hasNext()) {
			if (this.iterators.hasNext()) {
				this.iterator = this.iterators.next().iterator();
			} else {
				break;
			}
		}
	}
}

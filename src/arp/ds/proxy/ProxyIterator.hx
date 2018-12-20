package arp.ds.proxy;

class ProxyIterator<V, W> {

	private var iterator:Iterator<W>;
	private var proxy:W->V;

	inline public function new(iterator:Iterator<W>, proxy:W->V) {
		this.iterator = iterator;
		this.proxy = proxy;
	}

	inline public function hasNext():Bool return this.iterator.hasNext();
	inline public function next():V return this.proxy(this.iterator.next());
}

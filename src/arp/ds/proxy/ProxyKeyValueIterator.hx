package arp.ds.proxy;

class ProxyKeyValueIterator<K, V, X, W> {

	private var keyValueIterator:KeyValueIterator<X, W>;
	private var keyProxy:X->K;
	private var valueProxy:W->V;

	inline public function new(iterator:KeyValueIterator<X, W>, keyProxy:X->K, valueProxy:W->V) {
		this.keyValueIterator = iterator;
		this.keyProxy = keyProxy;
		this.valueProxy = valueProxy;
	}

	inline public function hasNext():Bool return this.keyValueIterator.hasNext();
	inline public function next():{ key:K, value:V } {
		var xw = this.keyValueIterator.next();
		return { key: this.keyProxy(xw.key), value: this.valueProxy(xw.value) };
	}
}

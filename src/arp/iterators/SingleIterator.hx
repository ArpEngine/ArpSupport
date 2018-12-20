package arp.iterators;

// this class exists because `inline public function iterator() return array.iterator();` is not inlined and allocates badly
class SingleIterator<T> {
	var item:T;
	var valid:Bool = true;
	inline public function new(t) this.item = t;
	inline public function hasNext() return valid;
	inline public function next() { valid = false; return item; }
}

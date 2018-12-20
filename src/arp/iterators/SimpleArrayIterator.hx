package arp.iterators;

// this class exists because `inline public function iterator() return array.iterator();` is not inlined and allocates badly
class SimpleArrayIterator<T> {
	var cur:Int = 0;
	var array:Array<T>;
	inline public function new(a) array = a;
	inline public function hasNext() return cur < array.length;
	inline public function next() return array[cur++];
}

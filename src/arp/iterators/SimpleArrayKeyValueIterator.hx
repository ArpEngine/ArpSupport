package arp.iterators;

class SimpleArrayKeyValueIterator<T> {
	public var key:Int = -1;
	public var value:T;
	var array:Array<T>;
	inline public function new(a) array = a;
	inline public function hasNext() return key + 1 < array.length;
	inline public function next() { key++; value = array[key]; return this; }
}

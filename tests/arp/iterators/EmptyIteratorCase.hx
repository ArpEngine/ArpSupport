package arp.iterators;

import picotest.PicoAssert.*;

class EmptyIteratorCase {

	public function new() {
	}

	public function testEmpty():Void {
		var iter:EmptyIterator<Int> = new EmptyIterator<Int>();
		assertFalse(iter.hasNext());
	}
}

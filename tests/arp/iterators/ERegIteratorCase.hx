package arp.iterators;

import picotest.PicoAssert.*;

class ERegIteratorCase {

	public function new() {
	}

	public function testUnmatch():Void {
		var iter:ERegIterator = new ERegIterator(~/a+/, "bcd");
		assertFalse(iter.hasNext());
	}

	public function testMatchOne():Void {
		var iter:ERegIterator = new ERegIterator(~/a+/, "abaaaac");
		assertTrue(iter.hasNext());
		assertTrue(iter.hasNext());
		assertEquals("a", iter.next());
		assertTrue(iter.hasNext());
		assertTrue(iter.hasNext());
		assertEquals("aaaa", iter.next());
		assertFalse(iter.hasNext());
		assertEquals(null, iter.next());
		assertFalse(iter.hasNext());
		assertEquals(null, iter.next());
	}
}

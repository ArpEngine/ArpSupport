package arp.iterators;

import picotest.PicoAssert.*;

class StepIteratorCase {

	public function new() {
	}

	public function testStepUp():Void {
		var iter:StepIterator<Int> = new StepIterator<Int>(10, 40, 10);
		assertTrue(iter.hasNext());
		assertEquals(10, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(20, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(30, iter.next());
		assertFalse(iter.hasNext());
	}

	public function testStepDown():Void {
		var iter:StepIterator<Int> = new StepIterator<Int>(40, 10, -10);
		assertTrue(iter.hasNext());
		assertEquals(40, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(30, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(20, iter.next());
		assertFalse(iter.hasNext());
	}

	public function testEmptyStepUp():Void {
		var iter:StepIterator<Int> = new StepIterator<Int>(10, 10, 10);
		assertFalse(iter.hasNext());
	}

	public function testEmptyStepDown():Void {
		var iter:StepIterator<Int> = new StepIterator<Int>(10, 10, -10);
		assertFalse(iter.hasNext());
	}
}

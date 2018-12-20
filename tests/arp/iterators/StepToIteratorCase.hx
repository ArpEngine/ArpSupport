package arp.iterators;

import picotest.PicoAssert.*;

class StepToIteratorCase {

	public function new() {
	}

	public function testStepUp():Void {
		var iter:StepToIterator<Int> = new StepToIterator<Int>(10, 40, 10);
		assertTrue(iter.hasNext());
		assertEquals(10, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(20, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(30, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(40, iter.next());
		assertFalse(iter.hasNext());
	}

	public function testStepDown():Void {
		var iter:StepToIterator<Int> = new StepToIterator<Int>(40, 10, -10);
		assertTrue(iter.hasNext());
		assertEquals(40, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(30, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(20, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(10, iter.next());
		assertFalse(iter.hasNext());
	}

	public function testEmptyStepUp():Void {
		var iter:StepToIterator<Int> = new StepToIterator<Int>(10, 10, 10);
		assertTrue(iter.hasNext());
		assertEquals(10, iter.next());
		assertFalse(iter.hasNext());
	}

	public function testEmptyStepDown():Void {
		var iter:StepToIterator<Int> = new StepToIterator<Int>(10, 10, -10);
		assertTrue(iter.hasNext());
		assertEquals(10, iter.next());
		assertFalse(iter.hasNext());
	}
}

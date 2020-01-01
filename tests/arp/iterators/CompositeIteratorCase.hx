package arp.iterators;

import picotest.PicoAssert.*;

class CompositeIteratorCase {

	public function testEmpty():Void {
		var iter:CompositeIterator<Null<Int>> = new CompositeIterator<Null<Int>>([]);
		assertFalse(iter.hasNext());
		assertNull(iter.next());
		assertFalse(iter.hasNext());
		assertNull(iter.next());
	}

	public function testDense():Void {
		var iter:CompositeIterator<Null<Int>> = new CompositeIterator<Null<Int>>([[1, 2], [3, 4]]);
		assertTrue(iter.hasNext());
		assertEquals(1, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(2, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(3, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(4, iter.next());
		assertFalse(iter.hasNext());
		assertEquals(null, iter.next());
		assertFalse(iter.hasNext());
		assertEquals(null, iter.next());
	}

	public function testSparse():Void {
		var iter:CompositeIterator<Null<Int>> = new CompositeIterator<Null<Int>>([[], [], [1, 2], [], [], [3, 4], [], []]);
		assertTrue(iter.hasNext());
		assertEquals(1, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(2, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(3, iter.next());
		assertTrue(iter.hasNext());
		assertEquals(4, iter.next());
		assertFalse(iter.hasNext());
		assertEquals(null, iter.next());
		assertFalse(iter.hasNext());
		assertEquals(null, iter.next());
	}
}

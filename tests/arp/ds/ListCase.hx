package arp.ds;

import arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class IntListCase extends ListCase<Int> {
	@Parameter
	override public function setup(provider:IDsImplProvider<IList<Int>>, valueFixture:IArpSupportFixture<Int>):Void {
		super.setup(provider, valueFixture);
	}
}

class ListCase<V> {

	private var me:IList<V>;
	private var v:IArpSupportFixture<V>;
	private var isStrictToString:Bool;

	@Parameter
	public function setup(provider:IDsImplProvider<IList<V>>, valueFixture:IArpSupportFixture<V>):Void {
		me = provider.create();
		v = valueFixture.create();
		isStrictToString = provider.isStrictToString();
	}

	public function testEmpty():Void {
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(v.a1));
	}

	public function testEmptyRemove():Void {
		me.remove(v.a1);
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(v.a1));
		me.clear();
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(v.a1));
	}

	public function testAddUniqueValue():Void {
		me.push(v.a1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(v.a1));
		assertFalse(me.hasValue(v.a2));
		me.push(v.a2);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(v.a1));
		assertTrue(me.hasValue(v.a2));
		me.remove(v.a1);
		assertFalse(me.isEmpty());
		assertFalse(me.hasValue(v.a1));
		assertTrue(me.hasValue(v.a2));
		me.clear();
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(v.a1));
		assertFalse(me.hasValue(v.a2));
	}

	public function testAddDuplicateValue():Void {
		me.push(v.a1);
		me.push(v.a1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(v.a1));
		me.remove(v.a1);
		if (me.isUniqueValue) {
			assertTrue(me.isEmpty());
			assertFalse(me.hasValue(v.a1));
		} else {
			assertFalse(me.isEmpty());
			assertTrue(me.hasValue(v.a1));
		}
	}

	public function testEmptyIterator():Void {
		var it:Iterator<V> = me.iterator();
		assertNotEquals(null, it);
		assertFalse(it.hasNext());
	}

	public function testOrderedIterator():Void {
		me.push(v.a1);
		me.push(v.a2);
		me.push(v.a3);
		me.push(v.a4);
		me.shift();
		me.unshift(v.a5);
		me.remove(v.a3);
		var it:Iterator<V> = me.iterator();
		var a:Array<V> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		assertEquals(v.a5, it.next());
		assertTrue(it.hasNext());
		assertEquals(v.a2, it.next());
		assertTrue(it.hasNext());
		assertEquals(v.a4, it.next());
		assertFalse(it.hasNext());
	}

	public function testIndexOf():Void {
		me.push(v.a1);
		me.push(v.a2);
		assertMatch(0, me.indexOf(v.a1));
		assertMatch(1, me.indexOf(v.a2));
		assertMatch(-1, me.indexOf(v.a3));
	}

	public function testFirstLast():Void {
		assertEquals(me.first(), null);
		assertEquals(me.last(), null);
		me.push(v.a1);
		assertEquals(me.first(), v.a1);
		assertEquals(me.last(), v.a1);
		me.push(v.a2);
		assertEquals(me.first(), v.a1);
		assertEquals(me.last(), v.a2);
		me.remove(v.a1);
		assertEquals(me.first(), v.a2);
		assertEquals(me.last(), v.a2);
	}

	public function testAmend():Void {
		me.push(v.a1);
		assertMatch([v.a1], [for (p in me.amend()) p.value]);
		for (p in me.amend()) p.append(v.a2);
		assertMatch([true, false], [for (p in me.amend()) (p.value == v.a1) && p.remove()]);
		assertMatch([v.a2], [for (p in me.amend()) p.value]);
		for (p in me.amend()) p.prepend(v.a3);
		assertMatch([v.a3, v.a2], [for (p in me.amend()) p.value]);
	}

	public function testBulkAmend():Void {
		me.push(v.a1);
		me.push(v.a5);
		for (p in me.amend()) {
			p.append(v.a2);
			p.append(v.a3);
			p.append(v.a4);
			break;
		}
		assertMatch([v.a1, v.a2, v.a3, v.a4, v.a5], [for (p in me.amend()) p.value]);
		assertMatch(
			[0, 1, 2, 3, 4],
			[for (p in me.amend()) { if (p.value == v.a1 || p.value == v.a2) p.remove(); p.index; } ]
		);
		assertMatch([v.a3, v.a4, v.a5], [for (p in me.amend()) p.value]);
	}

	public function testEmptyKeyValueIterator():Void {
		var it:KeyValueIterator<Int, V> = me.keyValueIterator();
		assertNotEquals(null, it);
		assertFalse(it.hasNext());
	}

	// for assertMatch()
	private function toAnon(kv:{key:Int, value:V}) return { key: kv.key, value: kv.value };

	public function testListKeyValueIterator():Void {
		me.push(v.a1);
		me.push(v.a2);
		me.push(v.a3);
		me.push(v.a4);
		me.shift();
		me.unshift(v.a5);
		me.remove(v.a3);
		var it:KeyValueIterator<Int, V> = me.keyValueIterator();
		var a:Array<V> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		assertMatch({ key: 0, value: v.a5 }, toAnon(it.next()));
		assertTrue(it.hasNext());
		assertMatch({ key: 1, value: v.a2 }, toAnon(it.next()));
		assertTrue(it.hasNext());
		assertMatch({ key: 2, value: v.a4 }, toAnon(it.next()));
		assertFalse(it.hasNext());
	}

	public function testEmptyToString():Void {
		assertEquals("[]", me.toString());
	}

	public function testToString():Void {
		me.push(v.a1);
		me.push(v.a2);
		me.push(v.a3);
		me.push(v.a4);
		me.shift();
		me.unshift(v.a5);
		me.remove(v.a3);
		var string:String = me.toString();
		if (isStrictToString) {
			assertEquals('[${v.a5}; ${v.a2}; ${v.a4}]', string);
		} else {
			assertNotNull(string);
		}
	}
}

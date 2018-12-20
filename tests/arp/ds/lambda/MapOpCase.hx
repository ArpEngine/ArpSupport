package arp.ds.lambda;

import arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class MapOpCase {

	private var me:IMap<String, Int>;
	private var provider:IDsImplProvider<IMap<String, Int>>;

	private function length():Int return [for (v in me) v].length;

	private function argA():IMap<String, Int> {
		var a:IMap<String, Int> = provider.create();
		a.set("1", 1);
		a.set("3", 2);
		a.set("5", 3);
		a.set("7", 4);
		return a;
	}

	private function argB():IMap<String, Int> {
		var b:IMap<String, Int> = provider.create();
		b.set("2", 5);
		b.set("3", 6);
		b.set("4", 7);
		b.set("5", 8);
		return b;
	}

	@Parameter
	public function setup(provider:IDsImplProvider<IMap<String, Int>>, keyFixture:IArpSupportFixture<String>, valueFixture:IArpSupportFixture<Int>):Void {
		me = provider.create();
		this.provider = provider;
	}

	public function testCopy():Void {
		var a:IMap<String, Int> = argA();
		me = MapOp.copy(a, me);
		assertNotEquals(a, me);
		assertEquals(4, length());
		assertEquals(1, me.get("1"));
		assertEquals(2, me.get("3"));
		assertEquals(3, me.get("5"));
		assertEquals(4, me.get("7"));
	}

	public function testAnd():Void {
		var a:IMap<String, Int> = argA();
		var b:IMap<String, Int> = argB();
		me = MapOp.and(a, b, me);
		assertNotEquals(a, me);
		assertNotEquals(b, me);
		assertEquals(2, length());
		assertEquals(2, me.get("3"));
		assertEquals(3, me.get("5"));
	}

	public function testOr():Void {
		var a:IMap<String, Int> = argA();
		var b:IMap<String, Int> = argB();
		me = MapOp.or(a, b, me);
		assertNotEquals(a, me);
		assertNotEquals(b, me);
		assertEquals(6, length());
		assertEquals(1, me.get("1"));
		assertEquals(2, me.get("3"));
		assertEquals(3, me.get("5"));
		assertEquals(4, me.get("7"));
		assertEquals(5, me.get("2"));
		assertEquals(7, me.get("4"));
	}

	public function testFilter():Void {
		var a:IMap<String, Int> = argA();
		me = MapOp.filter(a, function(v:Int):Bool return v % 2 == 1, me);
		assertNotEquals(a, me);
		assertEquals(2, length());
		assertEquals(1, me.get("1"));
		assertEquals(3, me.get("5"));
	}

	public function testMap():Void {
		var a:IMap<String, Int> = argA();
		me = MapOp.map(a, function(v:Int):Int return v * 2, me);
		assertNotEquals(a, me);
		assertEquals(4, length());
		assertEquals(2, me.get("1"));
		assertEquals(4, me.get("3"));
		assertEquals(6, me.get("5"));
		assertEquals(8, me.get("7"));
	}

	public function testBulkSet():Void {
		var a:IMap<String, Int> = argA();
		var b:IMap<String, Int> = argB();
		me = MapOp.bulkSet(me, a);
		me = MapOp.bulkSet(me, b);
		assertNotEquals(a, me);
		assertNotEquals(b, me);
		assertEquals(6, length());
		assertEquals(1, me.get("1"));
		assertEquals(4, me.get("7"));
		assertEquals(5, me.get("2"));
		assertEquals(6, me.get("3"));
		assertEquals(7, me.get("4"));
		assertEquals(8, me.get("5"));
	}

	public function testBulkSetAnon():Void {
		var a:IMap<String, Int> = argA();
		me = MapOp.bulkSetAnon(me, {a: 1, b: 2});
		me = MapOp.bulkSetAnon(me, {a: 3, c: 4});
		assertEquals(3, length());
		assertEquals(3, me.get("a"));
		assertEquals(2, me.get("b"));
		assertEquals(4, me.get("c"));
	}

	public function testToKeyArray():Void {
		assertMatch(containsInAnyOrder("1", "3", "5", "7"), MapOp.toKeyArray(argA()));
	}

	public function testToArray():Void {
		assertMatch(containsInAnyOrder(1, 2, 3, 4), MapOp.toArray(argA()));
	}

	public function testToAnon():Void {
		var a:IMap<String, Int> = provider.create();
		me.set("a", 1);
		me.set("b", 2);
		me.set("c", 3);
		assertMatch({ a: 1, b: 2, c: 3 }, MapOp.toAnon(me));
	}

}

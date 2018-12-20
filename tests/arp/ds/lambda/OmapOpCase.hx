package arp.ds.lambda;

import arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class OmapOpCase {

	private var me:IOmap<String, Int>;
	private var provider:IDsImplProvider<IOmap<String, Int>>;

	private function keys():Array<String> return [for (k in me.keys()) k];

	private function argA():IOmap<String, Int> {
		var a:IOmap<String, Int> = provider.create();
		a.addPair("1", 1);
		a.addPair("3", 2);
		a.addPair("5", 3);
		a.addPair("7", 4);
		return a;
	}

	private function argB():IOmap<String, Int> {
		var b:IOmap<String, Int> = provider.create();
		b.addPair("2", 5);
		b.addPair("3", 6);
		b.addPair("4", 7);
		b.addPair("5", 8);
		return b;
	}

	@Parameter
	public function setup(provider:IDsImplProvider<IOmap<String, Int>>, keyFixture:IArpSupportFixture<String>, valueFixture:IArpSupportFixture<Int>):Void {
		me = provider.create();
		this.provider = provider;
	}

	public function testCopy():Void {
		var a:IOmap<String, Int> = argA();
		me = OmapOp.copy(a, me);
		assertNotEquals(a, me);
		assertMatch(["1", "3", "5", "7"], keys());
		assertEquals(1, me.get("1"));
		assertEquals(2, me.get("3"));
		assertEquals(3, me.get("5"));
		assertEquals(4, me.get("7"));
	}

	public function testAnd():Void {
		var a:IOmap<String, Int> = argA();
		var b:IOmap<String, Int> = argB();
		me = OmapOp.and(a, b, me);
		assertNotEquals(a, me);
		assertNotEquals(b, me);
		assertMatch(["3", "5"], keys());
		assertEquals(2, me.get("3"));
		assertEquals(3, me.get("5"));
	}

	public function testOr():Void {
		var a:IOmap<String, Int> = argA();
		var b:IOmap<String, Int> = argB();
		me = OmapOp.or(a, b, me);
		assertNotEquals(a, me);
		assertNotEquals(b, me);
		assertMatch(["1", "3", "5", "7", "2", "4"], keys());
		assertEquals(1, me.get("1"));
		assertEquals(2, me.get("3"));
		assertEquals(3, me.get("5"));
		assertEquals(4, me.get("7"));
		assertEquals(5, me.get("2"));
		assertEquals(7, me.get("4"));
	}

	public function testFilter():Void {
		var a:IOmap<String, Int> = argA();
		me = OmapOp.filter(a, function(v:Int):Bool return v % 2 == 1, me);
		assertNotEquals(a, me);
		assertMatch(["1", "5"], keys());
		assertEquals(1, me.get("1"));
		assertEquals(3, me.get("5"));
	}

	public function testMap():Void {
		var a:IOmap<String, Int> = argA();
		me = OmapOp.map(a, function(v:Int):Int return v * 2, me);
		assertNotEquals(a, me);
		assertMatch(["1", "3", "5", "7"], keys());
		assertEquals(2, me.get("1"));
		assertEquals(4, me.get("3"));
		assertEquals(6, me.get("5"));
		assertEquals(8, me.get("7"));
	}

	public function testBulkAddPair():Void {
		var a:IOmap<String, Int> = argA();
		var b:IOmap<String, Int> = argB();
		me = OmapOp.bulkAddPair(me, a);
		me = OmapOp.bulkAddPair(me, b);
		assertNotEquals(a, me);
		assertNotEquals(b, me);
		assertMatch(["1", "3", "5", "7", "2", "4"], keys());
		assertEquals(1, me.get("1"));
		assertEquals(6, me.get("3"));
		assertEquals(8, me.get("5"));
		assertEquals(4, me.get("7"));
		assertEquals(5, me.get("2"));
		assertEquals(7, me.get("4"));
	}

	public function testBulkAddPairAnon():Void {
		var a:IOmap<String, Int> = argA();
		me = OmapOp.bulkAddPairAnon(me, {a: 1});
		me = OmapOp.bulkAddPairAnon(me, {b: 2});
		me = OmapOp.bulkAddPairAnon(me, {a: 3});
		me = OmapOp.bulkAddPairAnon(me, {c: 4});
		assertMatch(["a", "b", "c"], keys());
		assertEquals(3, me.get("a"));
		assertEquals(2, me.get("b"));
		assertEquals(4, me.get("c"));
	}

	public function testToKeyArray():Void {
		assertMatch(["1", "3", "5", "7"], OmapOp.toKeyArray(argA()));
	}

	public function testToArray():Void {
		assertMatch([1, 2, 3, 4], OmapOp.toArray(argA()));
	}

	public function testToAnon():Void {
		var a:IOmap<String, Int> = provider.create();
		me.addPair("a", 1);
		me.addPair("b", 2);
		me.addPair("c", 3);
		assertMatch({ a: 1, b: 2, c: 3 }, OmapOp.toAnon(me));
	}


}

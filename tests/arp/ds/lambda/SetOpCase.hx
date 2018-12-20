package arp.ds.lambda;

import arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class SetOpCase {

	private var me:ISet<Int>;
	private var provider:IDsImplProvider<ISet<Int>>;

	private function values():Array<Int> {
		var a:Array<Int> = [for (v in me) v];
		a.sort(function(a:Int, b:Int) return a - b);
		return a;
	}

	private function argA():ISet<Int> {
		var a:ISet<Int> = provider.create();
		a.add(1);
		a.add(3);
		a.add(5);
		a.add(7);
		return a;
	}

	private function argB():ISet<Int> {
		var b:ISet<Int> = provider.create();
		b.add(2);
		b.add(3);
		b.add(4);
		b.add(5);
		return b;
	}

	@Parameter
	public function setup(provider:IDsImplProvider<ISet<Int>>, valueFixture:IArpSupportFixture<Int>):Void {
		me = provider.create();
		this.provider = provider;
	}

	public function testCopy():Void {
		var a:ISet<Int> = argA();
		me = SetOp.copy(a, me);
		assertNotEquals(a, me);
		assertMatch([1, 3, 5, 7], values());
	}

	public function testAnd():Void {
		var a:ISet<Int> = argA();
		var b:ISet<Int> = argB();
		me = SetOp.and(a, b, me);
		assertNotEquals(a, me);
		assertNotEquals(b, me);
		assertMatch([3, 5], values());
	}

	public function testOr():Void {
		var a:ISet<Int> = argA();
		var b:ISet<Int> = argB();
		me = SetOp.or(a, b, me);
		assertNotEquals(a, me);
		assertNotEquals(b, me);
		assertMatch([1, 2, 3, 4, 5, 7], values());
	}

	public function testFilter():Void {
		var a:ISet<Int> = argA();
		me = SetOp.filter(a, function(v:Int):Bool return v % 4 == 1, me);
		assertNotEquals(a, me);
		assertMatch([1, 5], values());
	}

	public function testMap():Void {
		var a:ISet<Int> = argA();
		me = SetOp.map(a, function(v:Int):Int return v * 2, me);
		assertNotEquals(a, me);
		assertMatch([2, 6, 10, 14], values());
	}

	public function testBulkAdd():Void {
		var a:ISet<Int> = argA();
		var b:ISet<Int> = argB();
		me = SetOp.bulkAdd(me, a);
		me = SetOp.bulkAdd(me, b);
		assertNotEquals(a, me);
		assertNotEquals(b, me);
		assertMatch([1, 2, 3, 4, 5, 7], values());
	}

	public function testBulkAddArray():Void {
		var a:ISet<Int> = argA();
		me = SetOp.bulkAddArray(me, [12, 24, 36]);
		me = SetOp.bulkAddArray(me, [8, 16, 24, 32, 40]);
		assertMatch([8, 12, 16, 24, 32, 36, 40], values());
	}

	public function testToArray():Void {
		assertMatch(containsInAnyOrder(1, 3, 5, 7), SetOp.toArray(argA()));
	}

	public function testToAnon():Void {
		me.add(1);
		me.add(2);
		me.add(3);
		var anon:Dynamic = {};
		Reflect.setField(anon, "1", 1);
		Reflect.setField(anon, "2", 2);
		Reflect.setField(anon, "3", 3);
		assertMatch(anon, SetOp.toAnon(me));
	}

}

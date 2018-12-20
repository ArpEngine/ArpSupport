package arp.ds.lambda;

import arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class ListOpCase {

	private var me:IList<Int>;
	private var provider:IDsImplProvider<IList<Int>>;

	private function values():Array<Int> {
		var a:Array<Int> = [for (v in me) v];
		return a;
	}

	private function argA():IList<Int> {
		var a:IList<Int> = provider.create();
		a.push(1);
		a.push(3);
		a.push(5);
		a.push(7);
		return a;
	}

	private function argB():IList<Int> {
		var b:IList<Int> = provider.create();
		b.push(2);
		b.push(3);
		b.push(4);
		b.push(5);
		return b;
	}

	@Parameter
	public function setup(provider:IDsImplProvider<IList<Int>>, valueFixture:IArpSupportFixture<Int>):Void {
		me = provider.create();
		this.provider = provider;
	}

	public function testCopy():Void {
		var a:IList<Int> = argA();
		me = ListOp.copy(a, me);
		assertNotEquals(a, me);
		assertMatch([1, 3, 5, 7], values());
	}

	public function testAnd():Void {
		var a:IList<Int> = argA();
		var b:IList<Int> = argB();
		me = ListOp.and(a, b, me);
		assertNotEquals(a, me);
		assertNotEquals(b, me);
		assertMatch([3, 5], values());
	}

	public function testOr():Void {
		var a:IList<Int> = argA();
		var b:IList<Int> = argB();
		me = ListOp.or(a, b, me);
		assertNotEquals(a, me);
		assertNotEquals(b, me);
		assertMatch([1, 3, 5, 7, 2, 4], values());
	}

	public function testFilter():Void {
		var a:IList<Int> = argA();
		me = ListOp.filter(a, function(v:Int):Bool return v % 4 == 1, me);
		assertNotEquals(a, me);
		assertMatch([1, 5], values());
	}

	public function testMap():Void {
		var a:IList<Int> = argA();
		me = ListOp.map(a, function(v:Int):Int return v * 2, me);
		assertNotEquals(a, me);
		assertMatch([2, 6, 10, 14], values());
	}

	public function testBulkPush():Void {
		var a:IList<Int> = argA();
		var b:IList<Int> = argB();
		me = ListOp.bulkPush(me, a);
		me = ListOp.bulkPush(me, b);
		assertNotEquals(a, me);
		assertNotEquals(b, me);
		if (me.isUniqueValue) {
			assertMatch([1, 3, 5, 7, 2, 4], values());
		} else {
			assertMatch([1, 3, 5, 7, 2, 3, 4, 5], values());
		}
	}

	public function testBulkPushArray():Void {
		var a:IList<Int> = argA();
		me = ListOp.bulkPushArray(me, [12, 24, 36]);
		me = ListOp.bulkPushArray(me, [8, 16, 24, 32, 40]);
		if (me.isUniqueValue) {
			assertMatch([12, 24, 36, 8, 16, 32, 40], values());
		} else {
			assertMatch([12, 24, 36, 8, 16, 24, 32, 40], values());
		}
	}

	public function testToArray():Void {
		assertMatch([1, 3, 5, 7], ListOp.toArray(argA()));
	}

	public function testToAnon():Void {
		me.push(1);
		me.push(2);
		me.push(3);
		var anon:Dynamic = {};
		Reflect.setField(anon, "1", 1);
		Reflect.setField(anon, "2", 2);
		Reflect.setField(anon, "3", 3);
		assertMatch(anon, ListOp.toAnon(me));
	}

}

package arp.ds.proxy;

import arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class MapSelfProxyCase {

	private var me:IMap<String, Int>;
	private var provider:IDsImplProvider<IMap<String, Int>>;

	private function length():Int return [for (v in me) v].length;

	private function source():IMap<String, Int> {
		var a:IMap<String, Int> = provider.create();
		a.set("<1>", 10000);
		a.set("<3>", 20000);
		a.set("<5>", 30000);
		a.set("<7>", 40000);
		return a;
	}

	@Parameter
	public function setup(provider:IDsImplProvider<IMap<String, Int>>, keyFixture:IArpSupportFixture<String>, valueFixture:IArpSupportFixture<Int>):Void {
		this.provider = provider;
		me = new MapProxy(source(), ProxyCaseUtil.selfProxyString, ProxyCaseUtil.selfUnproxyString, ProxyCaseUtil.selfProxyInt, ProxyCaseUtil.selfUnproxyInt);
	}

	public function testProxy():Void {
		assertEquals(4, length());
		assertEquals(1, me.get("1"));
		assertEquals(2, me.get("3"));
		assertEquals(3, me.get("5"));
		assertEquals(4, me.get("7"));
		assertEquals("1", me.keyOf(1));
		assertEquals("3", me.keyOf(2));
		assertEquals("5", me.keyOf(3));
		assertEquals("7", me.keyOf(4));
	}

}

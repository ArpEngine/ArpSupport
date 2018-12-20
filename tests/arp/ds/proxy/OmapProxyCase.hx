package arp.ds.proxy;

import arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class OmapProxyCase {

	private var me:IOmap<Int, String>;
	private var provider:IDsImplProvider<IOmap<String, Int>>;

	private function keys():Array<Int> return [for (k in me.keys()) k];

	private function source():IOmap<String, Int> {
		var a:IOmap<String, Int> = provider.create();
		a.addPair("[1]", 4900);
		a.addPair("[3]", 5000);
		a.addPair("[5]", 5100);
		a.addPair("[7]", 5200);
		return a;
	}

	@Parameter
	public function setup(provider:IDsImplProvider<IOmap<String, Int>>, keyFixture:IArpSupportFixture<String>, valueFixture:IArpSupportFixture<Int>):Void {
		this.provider = provider;
		me = new OmapProxy(source(), ProxyCaseUtil.proxyString, ProxyCaseUtil.unproxyString, ProxyCaseUtil.proxyInt, ProxyCaseUtil.unproxyInt);
	}

	public function testProxy():Void {
		assertMatch([1, 3, 5, 7], keys());
		assertEquals("1", me.get(1));
		assertEquals("2", me.get(3));
		assertEquals("3", me.get(5));
		assertEquals("4", me.get(7));
		assertEquals(1, me.resolveName("1"));
		assertEquals(3, me.resolveName("2"));
		assertEquals(5, me.resolveName("3"));
		assertEquals(7, me.resolveName("4"));
	}

}

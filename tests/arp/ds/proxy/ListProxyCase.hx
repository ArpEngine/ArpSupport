package arp.ds.proxy;

import arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class ListProxyCase {

	private var me:IList<String>;
	private var provider:IDsImplProvider<IList<Int>>;

	private function values():Array<String> {
		var a:Array<String> = [for (v in me) v];
		return a;
	}

	private function source():IList<Int> {
		var a:IList<Int> = provider.create();
		a.push(4900);
		a.push(5100);
		a.push(5300);
		a.push(5500);
		return a;
	}

	@Parameter
	public function setup(provider:IDsImplProvider<IList<Int>>, valueFixture:IArpSupportFixture<Int>):Void {
		this.provider = provider;
		me = new ListProxy(source(), ProxyCaseUtil.proxyInt, ProxyCaseUtil.unproxyInt);
	}

	public function testProxy():Void {
		assertMatch(["1", "3", "5", "7"], values());
	}

}

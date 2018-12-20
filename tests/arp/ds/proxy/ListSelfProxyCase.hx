package arp.ds.proxy;

import arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class ListSelfProxyCase {

	private var me:IList<Int>;
	private var provider:IDsImplProvider<IList<Int>>;

	private function values():Array<Int> {
		var a:Array<Int> = [for (v in me) v];
		return a;
	}

	private function source():IList<Int> {
		var a:IList<Int> = provider.create();
		a.push(10000);
		a.push(30000);
		a.push(50000);
		a.push(70000);
		return a;
	}

	@Parameter
	public function setup(provider:IDsImplProvider<IList<Int>>, valueFixture:IArpSupportFixture<Int>):Void {
		this.provider = provider;
		me = new ListProxy(source(), ProxyCaseUtil.selfProxyInt, ProxyCaseUtil.selfUnproxyInt);
	}

	public function testProxy():Void {
		assertMatch([1, 3, 5, 7], values());
	}

}

package arp.ds.proxy;

import arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class SetSelfProxyCase {

	private var me:ISet<Int>;
	private var provider:IDsImplProvider<ISet<Int>>;

	private function values():Array<Int> {
		var a:Array<Int> = [for (v in me) v];
		a.sort((a:Int, b:Int) -> a - b);
		return a;
	}

	private function source():ISet<Int> {
		var a:ISet<Int> = provider.create();
		a.add(10000);
		a.add(30000);
		a.add(50000);
		a.add(70000);
		return a;
	}

	@Parameter
	public function setup(provider:IDsImplProvider<ISet<Int>>, valueFixture:IArpSupportFixture<Int>):Void {
		this.provider = provider;
		me = new SetProxy(source(), ProxyCaseUtil.selfProxyInt, ProxyCaseUtil.selfUnproxyInt);
	}

	public function testProxy():Void {
		assertMatch([1, 3, 5, 7], values());
	}

}

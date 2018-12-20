package arp.ds.proxy;

import arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class SetProxyCase {

	private var me:ISet<String>;
	private var provider:IDsImplProvider<ISet<Int>>;

	private function values():Array<String> {
		var a:Array<String> = [for (v in me) v];
		a.sort(function(a:String, b:String) return Reflect.compare(a, b));
		return a;
	}

	private function source():ISet<Int> {
		var a:ISet<Int> = provider.create();
		a.add(4900);
		a.add(5100);
		a.add(5300);
		a.add(5500);
		return a;
	}

	@Parameter
	public function setup(provider:IDsImplProvider<ISet<Int>>, valueFixture:IArpSupportFixture<Int>):Void {
		this.provider = provider;
		me = new SetProxy(source(), ProxyCaseUtil.proxyInt, ProxyCaseUtil.unproxyInt);
	}

	public function testProxy():Void {
		assertMatch(["1", "3", "5", "7"], values());
	}

}

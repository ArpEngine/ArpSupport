package arp.ds.proxy;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class ProxyCaseUtilCase {

	public function intProvider():Iterable<Array<Dynamic>> {
		return [[1], [2], [3], [4]];
	}

	public function stringProvider():Iterable<Array<Dynamic>> {
		return [["1"], ["2"], ["3"], ["4"], ["a"]];
	}

	// @Parameter("intProvider")
	// public function testProxyInt(i:Int):Void {
	// 	assertEquals(i, ProxyCaseUtil.unproxyInt(ProxyCaseUtil.proxyInt(i)));
	// }

	@Parameter("intProvider")
	public function testReverseProxyInt(i:Int):Void {
		assertEquals(i, ProxyCaseUtil.proxyString(ProxyCaseUtil.unproxyString(i)));
	}

	// @Parameter("intProvider")
	// public function testSelfProxyInt(i:Int):Void {
	// 	assertEquals(i, ProxyCaseUtil.selfUnproxyInt(ProxyCaseUtil.selfProxyInt(i)));
	// }

	@Parameter("intProvider")
	public function testReverseSelfProxyInt(i:Int):Void {
		assertEquals(i, ProxyCaseUtil.selfProxyInt(ProxyCaseUtil.selfUnproxyInt(i)));
	}

	// @Parameter("stringProvider")
	// public function testProxyString(s:String):Void {
	// 	assertEquals(s, ProxyCaseUtil.unproxyString(ProxyCaseUtil.proxyString(s)));
	// }

	@Parameter("stringProvider")
	public function testReverseProxyString(s:String):Void {
		assertEquals(s, ProxyCaseUtil.proxyInt(ProxyCaseUtil.unproxyInt(s)));
	}

	// @Parameter("stringProvider")
	// public function testSelfProxyString(s:String):Void {
	// 	assertEquals(s, ProxyCaseUtil.selfUnproxyString(ProxyCaseUtil.selfProxyString(s)));
	// }

	@Parameter("stringProvider")
	public function testReverseSelfProxyString(s:String):Void {
		assertEquals(s, ProxyCaseUtil.selfProxyString(ProxyCaseUtil.selfUnproxyString(s)));
	}

}

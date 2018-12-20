package arp.utils;

import picotest.PicoAssert.*;

class StringBufferCase {

	public function testFromInt():Void {
		var s:StringBuffer = 0;
		assertEquals("", s);
	}

	public function testFromString():Void {
		var s:StringBuffer = "test";
		assertEquals("test", s);
	}

	public function testAdd():Void {
		var s:StringBuffer = "a";
		s += "b";
		s += "c";
		assertEquals("abc", s);
	}

	public function testPush():Void {
		var s:StringBuffer = "a";
		s <<= "b";
		s <<= "c";
		assertEquals("ab\nc\n", s);
	}

	public function testSquiggle():Void {
		var s:StringBuffer = "a";
		s *= "
			b
			c
		";
		assertEquals("ab\nc", s);
	}

	public function testPushSquiggle():Void {
		var s:StringBuffer = "a";
		s >>= "
			b
			c
		";
		assertEquals("ab\nc\n", s);
	}
}

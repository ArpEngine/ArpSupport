package arp.utils;

import picotest.PicoAssert.*;

class ArpStringUtilCase {

	public function testIsNumeric():Void {
		assertFalse(ArpStringUtil.isNumeric(""));
		assertTrue(ArpStringUtil.isNumeric("0"));
		assertTrue(ArpStringUtil.isNumeric("123456789"));
		assertTrue(ArpStringUtil.isNumeric("00001234"));
		assertTrue(ArpStringUtil.isNumeric("0.123"));
		assertTrue(ArpStringUtil.isNumeric(".25"));
		assertTrue(ArpStringUtil.isNumeric("-0.456"));
		assertTrue(ArpStringUtil.isNumeric(".78"));
		assertTrue(ArpStringUtil.isNumeric("+5"));
		assertFalse(ArpStringUtil.isNumeric("1e37"));
		assertFalse(ArpStringUtil.isNumeric("NaN"));
		assertFalse(ArpStringUtil.isNumeric("Infinity"));
		assertFalse(ArpStringUtil.isNumeric("infinity"));
		assertFalse(ArpStringUtil.isNumeric("inf"));
		assertFalse(ArpStringUtil.isNumeric("Inf"));
		assertFalse(ArpStringUtil.isNumeric("null"));
		assertFalse(ArpStringUtil.isNumeric("undefined"));
		assertFalse(ArpStringUtil.isNumeric(null));
	}

	public function testParseHex():Void {
		assertEquals(0x0, ArpStringUtil.parseHex(""));
		assertEquals(0x0, ArpStringUtil.parseHex("0"));
		assertEquals(0x1, ArpStringUtil.parseHex("1"));
		assertEquals(0x9, ArpStringUtil.parseHex("9"));
		assertEquals(0xa, ArpStringUtil.parseHex("a"));
		assertEquals(0xf, ArpStringUtil.parseHex("f"));
		assertEquals(0xa, ArpStringUtil.parseHex("A"));
		assertEquals(0xf, ArpStringUtil.parseHex("F"));
		assertEquals(0x3f, ArpStringUtil.parseHex("3f"));
		assertEquals(0x7af7af, ArpStringUtil.parseHex("7aF7Af"));
	}

	public function testParseFloatDefault():Void {
		assertEquals(0.0, ArpStringUtil.parseFloatDefault("0.0", 0.0));
		assertEquals(1.0, ArpStringUtil.parseFloatDefault("1.0", 2.0));
		assertEquals(2.0, ArpStringUtil.parseFloatDefault("nan", 2.0));
		assertEquals(2.0, ArpStringUtil.parseFloatDefault("", 2.0));
		assertEquals(2.0, ArpStringUtil.parseFloatDefault(null, 2.0));
	}

	public function testParseRichFloat():Void {
		function getUnit(unit:String):Float return if (unit == "g") 16.0 else 1.0;

		assertEquals(0.0, ArpStringUtil.parseRichFloat("0.0", getUnit));
		assertEquals(6.0, ArpStringUtil.parseRichFloat("1+2+3", getUnit));
		assertEquals(16.0, ArpStringUtil.parseRichFloat("1g", getUnit));
		assertEquals(1.0, ArpStringUtil.parseRichFloat("1c", getUnit));
		assertEquals(1.0, ArpStringUtil.parseRichFloat("1e", getUnit));
		assertEquals(0.1, ArpStringUtil.parseRichFloat("1.0e-1.0", getUnit));
		assertEquals(-42.0, ArpStringUtil.parseRichFloat("-4.2e+1.0n", getUnit));
		assertEquals(16.0, ArpStringUtil.parseRichFloat("10.0e-1.0g", getUnit));
	}


	public function testSquiggle():Void {
		assertEquals("", ArpStringUtil.squiggle(""));
		assertEquals("", ArpStringUtil.squiggle("\n\n"));
		assertEquals("a", ArpStringUtil.squiggle("a"));
		assertEquals("a", ArpStringUtil.squiggle("\n\na\n\n"));
		assertEquals("a\n\nb", ArpStringUtil.squiggle(" \n a\n \n b\n "));
		assertEquals("a\n\n b", ArpStringUtil.squiggle(" \n a\n\n  b\n "));
		assertEquals("a\n b", ArpStringUtil.squiggle(" \n a\n  b\n "));
	}
}

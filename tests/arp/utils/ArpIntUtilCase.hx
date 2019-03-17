package arp.utils;

import picotest.PicoAssert.*;

class ArpIntUtilCase {

	public function testToInt8():Void {
		assertEquals(0, ArpIntUtil.toInt8(0));
		assertEquals(1, ArpIntUtil.toInt8(1));
		assertEquals(-1, ArpIntUtil.toInt8(-1));
		assertEquals(0x7f, ArpIntUtil.toInt8(0x7f));
		assertEquals(0xffffff80, ArpIntUtil.toInt8(0x80));
		assertEquals(0x7f, ArpIntUtil.toInt8(0xffffff7f));
		assertEquals(0xffffff80, ArpIntUtil.toInt8(0xffffff80));
	}

	public function testToInt16():Void {
		assertEquals(0, ArpIntUtil.toInt16(0));
		assertEquals(1, ArpIntUtil.toInt16(1));
		assertEquals(-1, ArpIntUtil.toInt16(-1));
		assertEquals(0x7fff, ArpIntUtil.toInt16(0x7fff));
		assertEquals(0xffff8000, ArpIntUtil.toInt16(0x8000));
		assertEquals(0x7fff, ArpIntUtil.toInt16(0xffff7fff));
		assertEquals(0xffff8000, ArpIntUtil.toInt16(0xffff8000));
	}
}

package arp.utils;

using arp.io.BytesTool;

class ArpIntUtil {
	inline public static function toInt8(value:Int):Int {
		return if ((value & 0x80) > 0) value | 0xffffff80 else value & 0x7f;
	}

	inline public static function toInt16(value:Int):Int {
		return if ((value & 0x8000) > 0) value | 0xffff8000 else value & 0x7fff;
	}
}


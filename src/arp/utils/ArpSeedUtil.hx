package arp.utils;

import arp.seed.ArpSeed;

class ArpSeedUtil {
	inline public static function parseIntDefault(seed:ArpSeed, defaultValue:Int = 0):Int {
		return ArpStringUtil.parseRichInt(seed.value, seed.env.getUnit, defaultValue);
	}

	inline public static function parseFloatDefault(seed:ArpSeed, defaultValue:Float = 0.0):Float {
		return ArpStringUtil.parseRichFloat(seed.value, seed.env.getUnit, defaultValue);
	}
}

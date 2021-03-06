package arp.curve.impl;

import arp.utils.ArpStringUtil;

class CurveFlat implements ICurve {

	public var l:Float;

	public var x0:Float;
	public var x1:Float;

	public function new(x0:Float, x1:Float, l:Float = 1.0) {
		this.x0 = x0;
		this.x1 = x1;
		this.l = l;
	}

	public function interpolate(t:Float):Float return if (t >= l) x1 else x0;

	public function accumulate(t0:Float, t1:Float):Float {
		return if ((t0 >= l) != (t1 >= l)) if (t1 > t0) x1 - x0 else x0 - x1 else 0;
	}

	public static function build(source:Array<String>, getUnit:String->Float):CurveFlat {
		return new CurveFlat(
			ArpStringUtil.parseRichFloat(source[0], getUnit),
			ArpStringUtil.parseRichFloat(source[1], getUnit),
			ArpStringUtil.parseRichFloat(source[2], getUnit)
		);
	}

	public function toString():String return [x0, x1, l].join(",") + ":flat";
}

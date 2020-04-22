package arp.curve.impl;

import arp.utils.ArpStringUtil;

class CurveBezier2 implements ICurve {

	public var l:Float;

	public var x0:Float;
	public var x1:Float;
	public var x2:Float;

	public function new(x0:Float, x1:Float, x2:Float, l:Float = 1.0) {
		this.x0 = x0;
		this.x1 = x1;
		this.x2 = x2;
		this.l = l;
	}

	public function interpolate(t:Float):Float {
		t /= l;
		var _t:Float = 1 - t;
		return (_t * _t) * x0 + 2 * (t * _t) * x1 + (t * t) * x2;
	}

	public function accumulate(t0:Float, t1:Float):Float {
		return interpolate(t1) - interpolate(t0);
	}

	public static function build(source:Array<String>, getUnit:String->Float):CurveBezier2 {
		return new CurveBezier2(
			ArpStringUtil.parseRichFloat(source[0], getUnit),
			ArpStringUtil.parseRichFloat(source[1], getUnit),
			ArpStringUtil.parseRichFloat(source[2], getUnit),
			ArpStringUtil.parseRichFloat(source[3], getUnit)
		);
	}

	public function toString():String return [x0, x1, x2, l].join(",") + ":bezier2";
}

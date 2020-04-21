package arp.curve.impl;

class CurveCubicAlt implements ICurve {

	public var l:Float;

	public var x0:Float;
	public var x1:Float;
	// a0 : gradient alt at t = 0
	// a1 : gradient alt at t = l
	public var a0:Float;
	public var a1:Float;

	public function new(x0:Float, a0:Float, a1:Float, x1:Float, l:Float = 0.0) {
		this.x0 = x0;
		this.x1 = x1;
		this.a0 = a0;
		this.a1 = a1;
		this.l = l;
	}

	public function interpolate(t:Float):Float {
		var slope:Float = (x1 - x0) / l;
		var s1:Float = t / l;
		var s2:Float = 1 - s1;
		return x0 + t * (slope + a0 * s2 * s2 + a1 * s1 * s2);
	}

	public function accumulate(t0:Float, t1:Float):Float {
		return interpolate(t1) - interpolate(t0);
	}
}

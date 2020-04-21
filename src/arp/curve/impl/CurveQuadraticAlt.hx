package arp.curve.impl;

class CurveQuadraticAlt implements ICurve {

	public var l:Float;

	public var x0:Float;
	public var x1:Float;
	// a : gradient alt at t = 0, t = l
	public var a:Float;

	public function new(x0:Float, a:Float, x1:Float, l:Float = 0.0) {
		this.x0 = x0;
		this.x1 = x1;
		this.a = a;
		this.l = l;
	}

	public function interpolate(t:Float):Float {
		var slope:Float = (x1 - x0) / l;
		var s1:Float = t / l;
		var s2:Float = 1 - s1;
		return x0 + t * (slope + a * s2);
	}

	public function accumulate(t0:Float, t1:Float):Float {
		return interpolate(t1) - interpolate(t0);
	}
}

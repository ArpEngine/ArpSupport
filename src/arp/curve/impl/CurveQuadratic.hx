package arp.curve.impl;

class CurveQuadratic implements ICurve {

	public var l:Float;

	public var x0:Float;
	public var x1:Float;
	// d : gradient at t = 0, t = l
	public var d:Float;

	public function new(x0:Float, d:Float, x1:Float, l:Float = 0.0) {
		this.x0 = x0;
		this.x1 = x1;
		this.d = d;
		this.l = l;
	}

	public function interpolate(t:Float):Float {
		var slope:Float = (x1 - x0) / l;
		var s1:Float = t / l;
		var s2:Float = 1 - s1;
		return x0 + t * (slope + (d - slope) * s2 * s2 + (d - slope) * s1 * s2);
	}

	public function accumulate(t0:Float, t1:Float):Float {
		return interpolate(t1) - interpolate(t0);
	}
}

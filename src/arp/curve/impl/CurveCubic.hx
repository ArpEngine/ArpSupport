package arp.curve.impl;

class CurveCubic implements ICurve {

	public var l:Float;

	public var x0:Float;
	public var x1:Float;
	// d0 : gradient at t = 0
	// d1 : gradient at t = l
	public var d0:Float;
	public var d1:Float;

	public function new(x0:Float, d0:Float, d1:Float, x1:Float, l:Float = 0.0) {
		this.x0 = x0;
		this.x1 = x1;
		this.d0 = d0;
		this.d1 = d1;
		this.l = l;
	}

	public function interpolate(t:Float):Float {
		var slope:Float = (x1 - x0) / l;
		var s1:Float = t / l;
		var s2:Float = 1 - s1;
		return x0 + t * (slope + (d0 - slope) * s2 * s2 + (d1 - slope) * s1 * s2);
	}

	public function accumulate(t0:Float, t1:Float):Float {
		return interpolate(t1) - interpolate(t0);
	}
}

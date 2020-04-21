package arp.curve.impl;

class CurveLinear implements ICurve {

	public var l:Float;

	public var x0:Float;
	public var x1:Float;

	public function new(x0:Float, x1:Float, l:Float = 1.0) {
		this.x0 = x0;
		this.x1 = x1;
		this.l = l;
	}

	public function interpolate(t:Float):Float return x0 + t * (x1 - x0) / l;
	public function accumulate(t0:Float, t1:Float):Float return (t1 - t0) * (x1 - x0) / l;
}

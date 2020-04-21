package arp.curve.impl;

class CurveBezier3 implements ICurve {

	public var l:Float;

	public var x0:Float;
	public var x1:Float;
	public var x2:Float;
	public var x3:Float;

	public function new(x0:Float, x1:Float, x2:Float, x3:Float, l:Float = 1.0) {
		this.x0 = x0;
		this.x1 = x1;
		this.x2 = x2;
		this.x3 = x3;
		this.l = l;
	}

	public function interpolate(t:Float):Float {
		t /= l;
		var _t:Float = 1 - t;
		var t2:Float = t * t;
		var _t2:Float = _t * _t;
		return (_t * _t2) * x0 + 3 * (t * _t2) * x1 + 3 * (_t * t2) * x2 + (t * t2) * x3;
	}

	public function accumulate(t0:Float, t1:Float):Float {
		return interpolate(t1) - interpolate(t0);
	}
}

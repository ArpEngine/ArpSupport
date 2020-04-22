package arp.curve.impl;

import picotest.PicoAssert.*;

class CurveQuadraticAltCase {
	private var curve:CurveQuadraticAlt;

	public function testFlat():Void {
		curve = new CurveQuadraticAlt(100, 0, 100, 4);
		assertMatch(100, curve.interpolate(0));
		assertMatch(100, curve.interpolate(1));
		assertMatch(100, curve.interpolate(4));
	}

	public function testLinear():Void {
		curve = new CurveQuadraticAlt(100, 0, 148, 4);
		assertMatch(100, curve.interpolate(0));
		assertMatch(112, curve.interpolate(1));
		assertMatch(148, curve.interpolate(4));
	}

	public function testQuadratic():Void {
		curve = new CurveQuadraticAlt(100, 12, 148, 4);
		assertMatch(100, curve.interpolate(0));
		assertMatch(121, curve.interpolate(1));
		assertMatch(136, curve.interpolate(2));
		assertMatch(145, curve.interpolate(3));
		assertMatch(148, curve.interpolate(4));
	}

	public function testAccumulate():Void {
		curve = new CurveQuadraticAlt(100, 0, 148, 4);
		assertMatch(0, curve.accumulate(0, 0));
		assertMatch(12, curve.accumulate(0, 1));
		assertMatch(12, curve.accumulate(1, 2));
		assertMatch(48, curve.accumulate(0, 4));
	}
}

package arp.curve.impl;

import picotest.PicoAssert.*;

class CurveFlatCase {
	private var curve:CurveFlat;

	public function testFlat():Void {
		curve = new CurveFlat(100, 148, 4);
		assertMatch(100, curve.interpolate(0));
		assertMatch(100, curve.interpolate(1));
		assertMatch(148, curve.interpolate(4));
	}

	public function testAccumulate():Void {
		curve = new CurveFlat(100, 148, 4);
		assertMatch(0, curve.accumulate(0, 0));
		assertMatch(0, curve.accumulate(0, 1));
		assertMatch(0, curve.accumulate(1, 2));
		assertMatch(48, curve.accumulate(2, 4));
		assertMatch(48, curve.accumulate(0, 4));
		assertMatch(0, curve.accumulate(4, 4));
	}
}

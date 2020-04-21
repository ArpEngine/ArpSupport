package arp.curve.impl;

import picotest.PicoAssert.*;

class CurveBezier3Case {
	private var curve:CurveBezier3;

	public function testFlat():Void {
		curve = new CurveBezier3(100, 100, 100, 100, 4);
		assertMatch(100, curve.interpolate(0));
		assertMatch(100, curve.interpolate(1));
		assertMatch(100, curve.interpolate(4));
	}

	public function testLinear():Void {
		curve = new CurveBezier3(100, 116, 132, 148, 4);
		assertMatch(100, curve.interpolate(0));
		assertMatch(112, curve.interpolate(1));
		assertMatch(148, curve.interpolate(4));
	}

	public function testBezier3():Void {
		curve = new CurveBezier3(100, 100, 148, 148, 4);
		assertMatch(100, curve.interpolate(0));
		assertMatch(107.5, curve.interpolate(1));
		assertMatch(124, curve.interpolate(2));
		assertMatch(140.5, curve.interpolate(3));
		assertMatch(148, curve.interpolate(4));
	}

	public function testAccumulate():Void {
		curve = new CurveBezier3(100, 116, 132, 148, 4);
		assertMatch(0, curve.accumulate(0, 0));
		assertMatch(12, curve.accumulate(0, 1));
		assertMatch(12, curve.accumulate(1, 2));
		assertMatch(48, curve.accumulate(0, 4));
	}
}

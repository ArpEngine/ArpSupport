package arp.curve.impl;

import picotest.PicoAssert.*;

class CurveBezier2Case {
	private var curve:CurveBezier2;

	private var nc(get, never):Float;
	private function get_nc():Float return Math.random();

	public function testFlat():Void {
		curve = new CurveBezier2(100, 100, 100, 4);
		assertMatch(100, curve.interpolate(0));
		assertMatch(100, curve.interpolate(1));
		assertMatch(100, curve.interpolate(4));
	}

	public function testLinear():Void {
		curve = new CurveBezier2(100, 124, 148, 4);
		assertMatch(100, curve.interpolate(0));
		assertMatch(112, curve.interpolate(1));
		assertMatch(148, curve.interpolate(4));
	}

	public function testBezier2():Void {
		curve = new CurveBezier2(100, 100, 148, 4);
		assertMatch(100, curve.interpolate(0));
		assertMatch(103, curve.interpolate(1));
		assertMatch(112, curve.interpolate(2));
		assertMatch(127, curve.interpolate(3));
		assertMatch(148, curve.interpolate(4));
	}

	public function testAccumulate():Void {
		curve = new CurveBezier2(100, 124, 148, 4);
		assertMatch(0, curve.accumulate(0, 0));
		assertMatch(12, curve.accumulate(0, 1));
		assertMatch(12, curve.accumulate(1, 2));
		assertMatch(48, curve.accumulate(0, 4));
	}
}

package arp.curve;
interface ICurve {
	var l:Float;

	function interpolate(t:Float):Float;
	function accumulate(t0:Float, t1:Float):Float;
}

package arp.curve;

import arp.curve.impl.CurveBezier2;
import arp.curve.impl.CurveBezier3;
import arp.curve.impl.CurveCubic;
import arp.curve.impl.CurveCubicAlt;
import arp.curve.impl.CurveFlat;
import arp.curve.impl.CurveLinear;
import arp.curve.impl.CurveQuadratic;
import arp.curve.impl.CurveQuadraticAlt;

class CurveBuilder {

	public static function build(source:String, getUnit:String->Float):ICurve {
		var l:Array<String> = source.split(":");
		var a:Array<String> = l[0].split(",");
		var klass:String = if (l.length == 0) "cubicA" else l[1];
		return switch (klass) {
			case "flat":
				CurveFlat.build(a, getUnit);
			case "linear":
				CurveLinear.build(a, getUnit);
			case "quadratic":
				CurveQuadratic.build(a, getUnit);
			case "quadraticA":
				CurveQuadraticAlt.build(a, getUnit);
			case "cubic":
				CurveCubic.build(a, getUnit);
			case "cubicA":
				CurveCubicAlt.build(a, getUnit);
			case "bezier2":
				CurveBezier2.build(a, getUnit);
			case "bezier3":
				CurveBezier3.build(a, getUnit);
			case _:
				CurveFlat.build(a, getUnit);
		}
	}
}

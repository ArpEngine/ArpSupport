package arp.utils.formatText;

import arp.utils.FormatText.TCustomAlign;
import arp.utils.FormatText.TCustomFormatter;
import arp.utils.FormatText.TFormatParams;

class ParametrizedNode implements INode {

	private var value:String;
	private var name:String = "";
	private var digits:Int = 0;
	private var precision:Int = 0;
	private var flags:String = "";
	private var defaultValue:String = "";

	private static final eregNew:EReg = ~/([0-9]+)?(\.[0-9]+)?([a-zA-Z]+)?/;

	private var flagAlign(get, never):PadAlign;
	private function get_flagAlign():PadAlign {
		var flagAlign:PadAlign = PadAlign.Left;
		if (this.flags.indexOf("r") >= 0) flagAlign = PadAlign.Right;
		if (this.flags.indexOf("c") >= 0) flagAlign = PadAlign.Center;
		return flagAlign;
	}

	public function new(value:String) {
		this.value = value;
		var array:Array<String> = value.substr(1, value.length - 2).split(":");
		if (array[0] != null) this.name = array[0];
		if (array[1] != null) {
			if (eregNew.match(array[1])) {
				var digits:String = eregNew.matched(1);
				var precision:String = eregNew.matched(2);
				var flags:String = eregNew.matched(3);
				if (digits != null) this.digits = Std.parseInt(digits);
				if (precision != null) this.precision = Std.parseInt(precision);
				if (flags != null) this.flags += flags;
			}
		}
		if (array[2] != null) this.defaultValue = array.splice(2, array.length - 2).join(":");
	}

	public function publishSelf(params:TFormatParams, customFormatter:TCustomFormatter, customAlign:TCustomAlign):String {
		if (params == null) return this.value;

		var param:Any = params(this.name);
		var str:String = null;
		if (param == null) {
			str = this.defaultValue;
		} else {
			str = customFormatter(param);
			if (str == null) str = Std.string(param);
		}

		var result = customAlign(str);
		if (result == null) result = doAlign(str, " ", this.digits, this.flagAlign);
		return result;
	}

	inline public static function doAlign(str:String, c:String, digits:Int, align:PadAlign):String {
		switch (align) {
			case PadAlign.Left:
				while (str.length < digits) str += c;
			case PadAlign.Right:
				while (str.length < digits) str = c + str;
			case PadAlign.Center:
				var b:Bool = false;
				while (str.length < digits) str = (b = !b) ? (str + c) : (c + str);
		}
		return str;
	}
}

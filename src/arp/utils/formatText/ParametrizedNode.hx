package arp.utils.formatText;

import arp.utils.FormatText.TCustomFormatter;
import arp.utils.FormatText.TFormatParams;

class ParametrizedNode implements INode {

	private var value:String;
	private var name:String = "";
	private var digits:Int = 0;
	private var precision:Int = 0;
	private var flags:String = "";
	private var defaultValue:String = "";

	private var flagAlign(get, never):String;
	private function get_flagAlign():String {
		var flagAlign:String = "l";
		if (this.flags.indexOf("r") >= 0) flagAlign = "r";
		if (this.flags.indexOf("c") >= 0) flagAlign = "c";
		return flagAlign;
	}

	public function new(value:String) {
		this.value = value;
		var array:Array<String> = value.substr(1, value.length - 2).split(":");
		if (array[0] != null) this.name = array[0];
		if (array[1] != null) {
			var ereg = ~/([0-9]*)(\.[0-9]+)?([a-zA-Z]*)/;
			while (ereg.match(array[1])) {
				var digits:String = ereg.matched(1);
				var precision:String = ereg.matched(2);
				var flags:String = ereg.matched(3);
				if (digits.length > 0) this.digits = Std.parseInt(digits);
				if (precision.length > 0) this.precision = Std.parseInt(precision);
				if (flags.length > 0) this.flags += flags;
			}
		}
		if (array[2] != null) this.defaultValue = array.splice(2, array.length - 2).join(":");
	}

	public function publishSelf(params:TFormatParams, customFormatter:TCustomFormatter):String {
		if (params == null) return this.value;

		var param:Any = params(this.name);
		var str:String = null;
		if (param == null) {
			str = this.defaultValue;
		} else {
			str = customFormatter(param);
			if (str == null) str = Std.string(param);
		}

		switch (this.flagAlign) {
			case "l":
				while (str.length < this.digits) str += " ";
			case "r":
				while (str.length < this.digits) str = " " + str;
			case "c":
				var b:Bool = false;
				while (str.length < this.digits) str = (b = !b) ? (str + " ") : (" " + str);
		}
		return str;
	}
}

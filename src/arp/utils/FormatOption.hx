package arp.utils;

class FormatOption {

	public static var empty(default, null):FormatOption = new FormatOption(0, 0, "");

	public var digits(default, null):Int = 0;
	public var precision(default, null):Int = 0;
	public var flags(default, null):String = "";

	public var flagAlign(get, never):PadAlign;
	private function get_flagAlign():PadAlign {
		var flagAlign:PadAlign = PadAlign.Left;
		if (this.flags.indexOf("r") >= 0) flagAlign = PadAlign.Right;
		if (this.flags.indexOf("c") >= 0) flagAlign = PadAlign.Center;
		return flagAlign;
	}

	private static final eregNew:EReg = ~/([0-9]+)?(\.[0-9]+)?([a-zA-Z]+)?/g;

	private function new(digits:Int, precision:Int, flags:String) {
		this.digits = digits;
		this.precision = precision;
		this.flags = flags;
	}

	public static function build(source:String):FormatOption {
		var digits:String = null;
		var precision:String = null;
		var flags:String = null;
		if (eregNew.match(source)) {
			digits = eregNew.matched(1);
			precision = eregNew.matched(2);
			flags = eregNew.matched(3);
		}
		return new FormatOption(
			if (digits != null) Std.parseInt(digits) else 0,
			if (precision != null) Std.parseInt(precision) else 0,
			if (flags != null) flags else ""
		);
	}
}

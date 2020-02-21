package arp.utils;

class FormatOption {

	public static var empty(default, null):FormatOption = new FormatOption(0, 0, "");

	public var digits(default, null):Int = 0;
	public var precision(default, null):Int = 0;
	public var flags(default, null):String = "";

	public function flag(char:String):Bool {
		return this.flags.indexOf(char) >= 0;
	}

	public var flagAlign(get, never):PadAlign;
	private function get_flagAlign():PadAlign {
		var flagAlign:PadAlign = PadAlign.Left;
		if (this.flag("r")) flagAlign = PadAlign.Right;
		if (this.flag("c")) flagAlign = PadAlign.Center;
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

	inline public function basicFormat(param:Any):String return Std.string(param);

	inline public function basicAlign(str:String, c:String):String {
		var digits:Int = this.digits;
		switch (this.flagAlign) {
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

enum PadAlign {
	Left;
	Center;
	Right;
}

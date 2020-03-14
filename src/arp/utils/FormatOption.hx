package arp.utils;

class FormatOption {

	public static var empty(default, null):FormatOption = new FormatOption(0, 0, "");

	public var digits(default, null):Int;
	public var precision(default, null):Int;
	public var flags(default, null):String;

	public var width(get, never):Int;
	private function get_width():Int return digits + if (precision > 0) precision + 1 else 0;

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

	private static final eregNew:EReg = ~/^([^.0-9]*)([0-9]+)?(\.[0-9]+)?([^.0-9].*|)$/g;

	private function new(digits:Int, precision:Int, flags:String) {
		this.digits = digits;
		this.precision = precision;
		this.flags = flags;
	}

	public static function build(source:String):FormatOption {
		if (!eregNew.match(source)) return FormatOption.empty;
		var flags1:String = eregNew.matched(1);
		var digits:String = eregNew.matched(2);
		var precision:String = eregNew.matched(3);
		var flags2:String = eregNew.matched(4);

		return new FormatOption(
			if (digits != null) Std.parseInt(digits) else 0,
			if (precision != null) Std.parseInt(precision) else 0,
			flags1 + flags2
		);
	}

	inline public function basicFormat(param:Any):String return Std.string(param);

	inline public function basicAlign(str:String, c:String):String {
		return this.basicPad(str, c, (this.width - str.length));
	}

	inline public function basicPad(str:String, c:String, n:Int):String {
		switch (this.flagAlign) {
			case PadAlign.Left:
				for (i in 0...n) str += c;
			case PadAlign.Right:
				for (i in 0...n) str = c + str;
			case PadAlign.Center:
				var b:Bool = false;
				for (i in 0...n) str = (b = !b) ? (str + c) : (c + str);
		}
		return str;
	}
}

enum PadAlign {
	Left;
	Center;
	Right;
}

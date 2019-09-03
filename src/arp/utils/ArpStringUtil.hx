package arp.utils;

class ArpStringUtil {
	private static var _isNumeric:EReg = ~/^[-+.0-9]+$/;
	inline public static function isNumeric(value:String):Bool {
		return if (value != null) _isNumeric.match(value) else false;
	}

	inline public static function isGeneratedId(value:String):Bool {
		return if (value != null) value.charAt(0) == "$" else false;
	}

	public static function parseHex(str:String):Int {
		var value:Int = 0;
		for (i in 0...str.length) {
			switch (str.charCodeAt(i)) {
				case n if (n >= 48 && n < 58): value = (value << 4) + n - 48;
				case a if (a >= 65 && a < 71): value = (value << 4) + a - 55;
				case a if (a >= 97 && a < 103): value = (value << 4) + a - 87;
				case c: throw 'invalid character $c';
			}
		}
		return value;
	}

	inline public static function parseIntDefault(string:String, defaultValue:Int = 0):Int {
		var value:Null<Int> = Std.parseInt(string);
		return if (value == null) defaultValue else value;
	}

	inline public static function parseFloatDefault(string:String, defaultValue:Float = 0.0):Float {
		var value:Float = Std.parseFloat(string);
		return if (Math.isNaN(value)) defaultValue else value;
	}

	inline public static function parseRichInt(str:String, getUnit:String->Float, defaultValue:Int = 0):Int {
		return Std.int(parseRichFloat(str, getUnit, defaultValue));
	}

	private static var _parseRichFloat:EReg = ~/([-+]?(?:[0-9]+\.?[0-9]*)|(?:\.[0-9]+))([a-zA-Z]*)/;
	public static function parseRichFloat(str:String, getUnit:String->Float, defaultValue:Float = 0.0):Float {
		if (str == null) return defaultValue;
		var value:Float = 0.0;
		var ereg:EReg = _parseRichFloat;
		var pos = 0;
		while (ereg.matchSub(str, pos)) {
			pos += ereg.matchedPos().len;
			var coefficient:Float = Std.parseFloat(ereg.matched(1));
			var unit:String = ereg.matched(2);
			if (unit == "e") {
				if (ereg.matchSub(str, pos)) {
					pos += ereg.matchedPos().len;
					coefficient *= Math.pow(10, Std.parseFloat(ereg.matched(1)));
					unit = ereg.matched(2);
				}
			}
			value += coefficient * getUnit(unit);
		}
		return value;
	}

	private static var _squiggle = ~/^\s*/;
	public static function squiggle(str:String):String {
		var lines:Array<String> = str.split("\n");
		var indentCounts:Array<Int> = lines.filter(line -> ~/\S/.match(line)).map(line -> {
			_squiggle.match(line);
			return _squiggle.matched(0).length;
		});

		var indentCount:Int = Lambda.fold(indentCounts, (a, b) -> if (a < b) a else b, str.length);

		while (lines.length > 0 && lines[0].length <= indentCount) lines.shift();
		while (lines.length > 0 && lines[lines.length - 1].length <= indentCount) lines.pop();

		return lines.map(line -> line.substr(indentCount)).join("\n");
	}
}

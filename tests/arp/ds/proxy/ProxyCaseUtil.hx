package arp.ds.proxy;

class ProxyCaseUtil {

	public static function proxyInt(v:Null<Int>):Null<String> {
		function decode(x:Int):String return String.fromCharCode(x);

		if (v == null) return null;
		return decode(Math.floor(v / 100));
	}

	public static function unproxyInt(v:Null<String>):Null<Int> {
		function encode(x:String):Int return x.charCodeAt(0);

		if (v == null) return null;
		return encode(v) * 100;
	}

	public static function proxyString(v:Null<String>):Null<Int> {
		function encode(x:String):Int return Std.parseInt(x);

		if (v == null) return null;
		return encode(v.substr(1, v.length - 2));
	}

	public static function unproxyString(v:Null<Int>):Null<String> {
		function decode(x:Int):String return Std.string(x);

		if (v == null) return null;
		return '[${decode(v)}]';
	}

	public static function selfProxyInt(v:Null<Int>):Null<Int> {
		if (v == null) return null;
		return Math.floor(v / 10000);
	}

	public static function selfUnproxyInt(v:Null<Int>):Null<Int> {
		if (v == null) return null;
		return v * 10000;
	}

	public static function selfProxyString(v:Null<String>):Null<String> {
		if (v == null) return null;
		return v.substr(1, v.length - 2);
	}

	public static function selfUnproxyString(v:Null<String>):Null<String> {
		if (v == null) return null;
		return '<$v>';
	}

}

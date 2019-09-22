package arp.utils;

import arp.iterators.ERegIterator;

class FormatText {

	private var _nodes:Array<INode>;

	public function new(value:String, customFormatter:Any->String = null) {
		this._nodes = [];

		if (customFormatter != null) this.customFormatter = customFormatter;

		for (str in new ERegIterator(~/[^{]+|\{[^}]*\}/, value)) {
			switch (str.charAt(0)) {
				case "\x7B":
					this._nodes.push(new ParametrizedNode(str));
				default:
					this._nodes.push(new FixedNode(str));
			}
		}
	}

	public function publish(params:String->Any):String {
		var result:String = "";
		for (node in this._nodes) {
			result += node.publishSelf(params, customFormatter);
		}
		return result;
	}

	private dynamic function customFormatter(param:Any):String return null;
}

private interface INode {
	function publishSelf(params:String->Any, customFormatter:Any->String):String;
}

private class FixedNode implements INode {
	private var value:String;

	public function new(value:String) this.value = value;

	public function publishSelf(params:String->Any, customFormatter:Any->String):String return this.value;
}

private class ParametrizedNode implements INode {

	private var value:String;
	private var _name:String = "";
	private var _flagAlign:String = "l";
	private var _flagDigits:Int = 0;
	private var _flagPrecision:Int = 0;
	private var _flagFormat:String = "s";
	private var _default:String = " ";

	public function new(value:String) {
		this.value = value;
		var array:Array<String> = value.substr(1, value.length - 2).split(":");
		if (array[0] != null) this._name = array[0];
		if (array[1] != null) {
			for (flag in new ERegIterator(~/[0-9]+|\.[0-9]+|[lrcsz]/, array[1])) {
				switch (flag.charAt(0)) {
					case "l", "r", "c":
						this._flagAlign = flag;
					case "s":
						this._flagFormat = flag;
					case "z":
						this._flagFormat = flag;
						this._default = "　";
					case ".":
						this._flagPrecision = Std.parseInt(flag.substr(1));
					default:
						this._flagDigits = Std.parseInt(flag);
				}
			}
		}
		if (array[2] != null) this._default = array[2];
	}

	private static function toZenChar(f:EReg):String {
		return "０１２３４５６７８９".charAt(Std.parseInt(f.matched(0)));
	}

	public static function toZenString(value:Float):String {
		return ~/./.map(Std.string(value), toZenChar);
	}

	public function publishSelf(params:String->Any, customFormatter:Any->String):String {
		if (params == null) return this.value;

		var param:Any = params(this._name);
		var str:String = customFormatter(param);
		if (str == null) {
			if (Std.is(param, Float)) {
				switch (this._flagFormat) {
					case "z":
						str = toZenString(param);
					case _:
				}
			}
		}
		if (str == null) str = Std.string(param);

		switch (this._flagAlign) {
			case "l":
				while (str.length < this._flagDigits) str += this._default;
			case "r":
				while (str.length < this._flagDigits) str = this._default + str;
			case "c":
				var b:Bool = false;
				while (str.length < this._flagDigits) str = (b = !b) ? (str + this._default) : (this._default + str);
		}
		return str;
	}
}

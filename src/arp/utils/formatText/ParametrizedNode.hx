package arp.utils.formatText;

import arp.utils.FormatText.TCustomFormatter;
import arp.utils.FormatText.TFormatParams;
import arp.iterators.ERegIterator;

class ParametrizedNode implements INode {

	private var value:String;
	private var _name:String = "";
	private var _flagAlign:String = "l";
	private var _flagDigits:Int = 0;
	private var _flagPrecision:Int = 0;
	private var _default:String = " ";

	public function new(value:String) {
		this.value = value;
		var array:Array<String> = value.substr(1, value.length - 2).split(":");
		if (array[0] != null) this._name = array[0];
		if (array[1] != null) {
			for (flag in new ERegIterator(~/[0-9]+|\.[0-9]+|[lrc]/, array[1])) {
				switch (flag.charAt(0)) {
					case "l", "r", "c":
						this._flagAlign = flag;
					case ".":
						this._flagPrecision = Std.parseInt(flag.substr(1));
					default:
						this._flagDigits = Std.parseInt(flag);
				}
			}
		}
		if (array[2] != null) this._default = array[2];
	}

	public function publishSelf(params:TFormatParams, customFormatter:TCustomFormatter):String {
		if (params == null) return this.value;

		var param:Any = params(this._name);
		var str:String = customFormatter(param);
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

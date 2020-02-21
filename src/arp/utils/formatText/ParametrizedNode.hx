package arp.utils.formatText;

import arp.utils.FormatText.TCustomAlign;
import arp.utils.FormatText.TCustomFormatter;
import arp.utils.FormatText.TFormatParams;

class ParametrizedNode implements INode {

	private var value:String;
	private var name:String;
	private var formatOption:FormatOption;
	private var defaultValue:String;

	public function new(value:String) {
		this.value = value;
		var array:Array<String> = value.substr(1, value.length - 2).split(":");
		this.name = if (array[0] != null) array[0] else "";
		this.formatOption = if (array[1] != null) FormatOption.build(array[1]) else FormatOption.empty;
		this.defaultValue = if (array[2] != null) array.splice(2, array.length - 2).join(":") else "";
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
		if (result == null) result = doAlign(str, " ", this.formatOption);
		return result;
	}

	inline public static function doAlign(str:String, c:String, formatOption:FormatOption):String {
		var digits:Int = formatOption.digits;
		switch (formatOption.flagAlign) {
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

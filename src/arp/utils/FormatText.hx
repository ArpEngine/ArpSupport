package arp.utils;

import arp.iterators.ERegIterator;
import arp.utils.formatText.FixedNode;
import arp.utils.formatText.INode;
import arp.utils.formatText.ParametrizedNode;

class FormatText {

	public var source(default, null):String;
	private var _nodes:Array<INode>;

	private static final eregNew:EReg = ~/[^{]+|\{[^}]*\}/;

	public function new(value:String, customFormatter:Null<CustomFormatter> = null, customAlign:Null<CustomAlign> = null) {
		this.source = value;
		this._nodes = [];

		if (customFormatter != null) this.customFormatter = customFormatter;
		if (customAlign != null) this.customAlign = customAlign;

		for (str in new ERegIterator(eregNew, value)) {
			switch (str.charAt(0)) {
				case "\x7B":
					this._nodes.push(new ParametrizedNode(str));
				default:
					this._nodes.push(new FixedNode(str));
			}
		}
	}

	public function publish(params:FormatParams):String {
		var result:StringBuf = new StringBuf();
		for (node in this._nodes) result.add(node.publishSelf(params, customFormatter, customAlign));
		return result.toString();
	}

	inline public function publishAnon(params:Dynamic):String return this.publish(FormatParams.fromAnon(params));

	private dynamic function customFormatter(param:Any, formatOption:FormatOption):String return null;
	private dynamic function customAlign(str:String, formatOption:FormatOption):String return null;
}

typedef TFormatParams = (name:String)->Any;
abstract FormatParams(TFormatParams) to TFormatParams {
	@:from inline public static function fromFunc(func:(name:String)->Any):FormatParams return cast func;
	@:from inline public static function fromArray<T>(array:Array<T>):FormatParams return cast ((name:String) -> array[Std.parseInt(name)]);
	inline public static function fromAnon(anon:Dynamic):FormatParams return (name:String) -> Reflect.field(anon, name);
}

typedef TCustomFormatter = (param:Any, formatOption:FormatOption)->String;
abstract CustomFormatter(TCustomFormatter) to TCustomFormatter {
	@:from inline public static function fromFunc(func:(param:Any)->String):CustomFormatter return (param:Any, formatOption:FormatOption) -> func(param);
	@:from inline public static function fromFuncOption(func:(param:Any, formatOption:FormatOption)->String):CustomFormatter return cast func;
}

typedef TCustomAlign = (str:String, formatOption:FormatOption)->String;
abstract CustomAlign(TCustomAlign) to TCustomAlign {
	@:from inline public static function fromFunc(func:(str:String)->String):CustomAlign return (str:String, formatOption:FormatOption) -> func(str);
	@:from inline public static function fromFuncOption(func:(str:String, formatOption:FormatOption)->String):CustomAlign return cast func;
}

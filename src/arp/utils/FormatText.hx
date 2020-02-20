package arp.utils;

import arp.utils.formatText.FixedNode;
import arp.utils.formatText.INode;
import arp.utils.formatText.ParametrizedNode;
import arp.iterators.ERegIterator;

class FormatText {

	private var _nodes:Array<INode>;

	public function new(value:String, customFormatter:CustomFormatter = null) {
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

	public function publish(params:FormatParams):String {
		var result:String = "";
		for (node in this._nodes) {
			result += node.publishSelf(params, customFormatter);
		}
		return result;
	}

	private dynamic function customFormatter(param:Any):String return null;
}

typedef TFormatParams = (name:String)->Any;
abstract FormatParams(TFormatParams) to TFormatParams {
	@:from inline public static function fromFunc(func:(name:String)->Any):FormatParams return cast func;
	@:from inline public static function fromArray<T>(array:Array<T>):FormatParams return cast ((name:String) -> array[Std.parseInt(name)]);
	@:from inline public static function fromAnon(anon:Dynamic):FormatParams return (name:String) -> Reflect.field(anon, name);
}

typedef TCustomFormatter = (param:Any)->String;
abstract CustomFormatter(TCustomFormatter) to TCustomFormatter {
	@:from inline public static function fromFunc(func:(param:Any)->String):CustomFormatter return cast func;
}

package arp.utils;

import arp.utils.formatText.FixedNode;
import arp.utils.formatText.INode;
import arp.utils.formatText.ParametrizedNode;
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

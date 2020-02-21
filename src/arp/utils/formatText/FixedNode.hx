package arp.utils.formatText;

import arp.utils.FormatText.TCustomAlign;
import arp.utils.FormatText.TCustomFormatter;
import arp.utils.FormatText.TFormatParams;

class FixedNode implements INode {
	private var value:String;

	public function new(value:String) this.value = value;

	public function publishSelf(params:TFormatParams, customFormatter:TCustomFormatter, customAlign:TCustomAlign):String return this.value;
}


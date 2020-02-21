package arp.utils.formatText;

import arp.utils.FormatText.TCustomAlign;
import arp.utils.FormatText.TCustomFormatter;
import arp.utils.FormatText.TFormatParams;

interface INode {
	function publishSelf(params:TFormatParams, customFormatter:TCustomFormatter, customAlign:TCustomAlign):String;
}


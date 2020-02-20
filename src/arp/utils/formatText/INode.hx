package arp.utils.formatText;

import arp.utils.FormatText.TCustomFormatter;
import arp.utils.FormatText.TFormatParams;

interface INode {
	function publishSelf(params:TFormatParams, customFormatter:TCustomFormatter):String;
}


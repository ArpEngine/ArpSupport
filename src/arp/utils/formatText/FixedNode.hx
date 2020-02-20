package arp.utils.formatText;

class FixedNode implements INode {
	private var value:String;

	public function new(value:String) this.value = value;

	public function publishSelf(params:String->Any, customFormatter:Any->String):String return this.value;
}


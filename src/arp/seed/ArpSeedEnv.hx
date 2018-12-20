package arp.seed;

import arp.utils.ArpStringUtil;

abstract ArpSeedEnv(ArpSeedEnvNode) {

	inline public static function empty():ArpSeedEnv return new ArpSeedEnv(ArpSeedEnvNode.empty);

	inline private function new(impl:ArpSeedEnvNode) this = impl;

	inline public function get(key:String):String {
		return this.get(key).value;
	}

	inline public function getDefaultSeeds(key:String):Array<ArpSeed> {
		return this.get('seed.$key').seeds;
	}

	inline public function getDefaultClassSeeds(key:String, className:String):Array<ArpSeed> {
		return this.get('seed.$key.$className').seeds;
	}

	inline public function getDefaultClass(key:String):String {
		return this.get('default.$key').value;
	}

	inline public function getUnit(unit:String):Float {
		return ArpStringUtil.parseFloatDefault(this.get('unit.$unit').value, 1.0);
	}

	inline public function add(key:String, value:String):Void {
		this = new ArpSeedEnvNode(key, value, [], this);
	}

	inline public function addSeeds(key:String, value:String, seeds:Array<ArpSeed>):Void {
		this = new ArpSeedEnvNode(key, value, seeds, this);
	}
}

private class ArpSeedEnvNode {

	private var key:String;
	public var value(default, null):String;
	public var seeds(default, null):Array<ArpSeed>;
	private var rest:ArpSeedEnvNode;
	private var map:Map<String, ArpSeedEnvNode>;

	private static var _empty:ArpSeedEnvNode;
	public static var empty(get, never):ArpSeedEnvNode;
	private static function get_empty():ArpSeedEnvNode return if (_empty != null) _empty else _empty = new ArpSeedEnvNode(null, null, [], null);

	public function new(key:String, value:String, seeds:Array<ArpSeed>, rest:ArpSeedEnvNode) {
		this.key = key;
		this.value = value;
		this.seeds = seeds;
		this.rest = rest;
	}

	public function get(key:String):ArpSeedEnvNode {
		if (this.map == null) this.compile();
		var n = this.map.get(key);
		return (n != null) ? n : empty;
	}

	inline private function compile():Void {
		this.map = new Map<String, ArpSeedEnvNode>();
		recCompile(this.map, this);
	}

	private static function recCompile(map:Map<String, ArpSeedEnvNode>, node:ArpSeedEnvNode):Void {
		if (node.key == null) return;
		recCompile(map, node.rest);
		map.set(node.key, node);
	}
}

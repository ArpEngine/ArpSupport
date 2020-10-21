package arp.seed.impl;

import arp.iterators.SimpleArrayIterator;
import arp.seed.ArpSeedValueKind;

class ArpComplexSeed extends ArpSeed {

	override private function get_isSimple():Bool return this._isSimple;
	private var _isSimple:Bool = true;
	override private function get_value():String return this._value;
	private var _value:Null<String>;
	override private function get_valueKind():ArpSeedValueKind return if (this.isSimple) ArpSeedValueKind.Literal else ArpSeedValueKind.None;

	override private function get_className():String return _className;
	private var _className(default, null):String;
	override private function get_name():String return _name;
	private var _name(default, null):String;
	override private function get_heat():String return _heat;
	private var _heat(default, null):String;

	override public function iterator():Iterator<ArpSeed> return new SimpleArrayIterator(this.childrenWithEnv);

	private var children:Array<ArpSeed>;

	private var childrenWithEnv(get, null):Array<ArpSeed>;
	private function get_childrenWithEnv():Array<ArpSeed> {
		var value:Array<ArpSeed> = childrenWithEnv;
		if (value != null) return value;
		value = [];
		for (x in this.env.getDefaultSeeds(this.seedName)) value.push(x);
		for (x in this.env.getDefaultClassSeeds(this.seedName, this.className)) value.push(x);
		for (x in this.children) value.push(x);
		childrenWithEnv = value;
		return value;
	}

	public function new(typeName:String, className:String, name:String, key:String, heat:String, children:Array<ArpSeed>, env:ArpSeedEnv) {
		super(typeName);
		this.key = key;
		this.env = env;

		this._className = className;
		this._name = name;
		this._heat = heat;
		this.children = children;
		for (child in children) {
			if (child.seedName == "value") {
				this._value = child.value;
			} else {
				this._isSimple = false;
				this._value = null;
				break;
			}
		}
	}
}

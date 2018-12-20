package arp.seed.impl;

import arp.iterators.SimpleArrayIterator;
import arp.seed.ArpSeedValueKind;

class ArpComplexSeed extends ArpSeed {

	private var element:ArpComplexSeedElement;

	private var childrenWithEnv(get, null):Array<ArpSeed>;
	private function get_childrenWithEnv():Array<ArpSeed> {
		var value:Array<ArpSeed> = childrenWithEnv;
		if (value != null) return value;
		value = [];
		for (x in this.env.getDefaultSeeds(this.seedName)) {
			value.push(x);
		}
		for (x in this.env.getDefaultClassSeeds(this.seedName, this.className)) {
			value.push(x);
		}
		for (x in this.element.children) {
			value.push(x);
		}
		childrenWithEnv = value;
		return value;
	}

	public function new(typeName:String, className:String, name:String, key:String, heat:String, children:Array<ArpSeed>, env:ArpSeedEnv) {
		super(typeName);
		this.key = key;
		this.env = env;
		this.element = new ArpComplexSeedElement(className, name, heat, children);
	}

	override private function get_isSimple():Bool return this.element.isSimple;
	override private function get_value():String return this.element.value;
	override private function get_valueKind():ArpSeedValueKind return this.element.valueKind;

	override private function get_className():String return element.className;
	override private function get_name():String return element.name;
	override private function get_heat():String return element.heat;

	override public function iterator():Iterator<ArpSeed> return new SimpleArrayIterator(this.childrenWithEnv);
}

class ArpComplexSeedElement {

	public var className(default, null):String;
	public var name(default, null):String;
	public var heat(default, null):String;

	public var isSimple(default, null):Bool = true;
	public var value(default, null):Null<String>;
	public var valueKind(get, never):ArpSeedValueKind;
	private function get_valueKind():ArpSeedValueKind return if (this.isSimple) ArpSeedValueKind.Literal else ArpSeedValueKind.None;

	public var children(default, null):Array<ArpSeed>;

	public function new(className:String, name:String, heat:String, children:Array<ArpSeed>) {
		this.className = className;
		this.name = name;
		this.heat = heat;
		this.children = children;
		for (child in children) {
			if (child.seedName == "value") {
				this.value = child.value;
			} else {
				isSimple = false;
				this.value = null;
				break;
			}
		}
	}
}

package arp.seed.impl;

import arp.iterators.SimpleArrayIterator;
import arp.seed.ArpSeedValueKind;

class ArpComplexSeed extends ArpSeed {

	override private function get_valueKind():ArpSeedValueKind return if (this.isSimple) ArpSeedValueKind.Literal else ArpSeedValueKind.None;

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

	public function new(seedName:String, className:String, name:String, key:String, heat:String, children:Array<ArpSeed>, env:ArpSeedEnv) {
		super(seedName, key, env);

		this.className = className;
		this.name = name;
		this.heat = heat;
		this.children = children;
		this.isSimple = true;
		for (child in children) {
			if (child.seedName == "value") {
				this.value = child.value;
			} else {
				this.isSimple = false;
				this.value = null;
				break;
			}
		}
	}
}

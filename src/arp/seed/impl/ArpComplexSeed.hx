package arp.seed.impl;

import arp.seed.ArpSeedValueKind;

class ArpComplexSeed extends ArpSeed {

	override private function get_valueKind():ArpSeedValueKind return if (this.isSimple) ArpSeedValueKind.Literal else ArpSeedValueKind.None;

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

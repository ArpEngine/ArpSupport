package arp.seed.impl;

import arp.seed.ArpSeedValueKind;

class ArpSimpleSeed extends ArpSeed {

	public function new(seedName:String, key:String, value:String, env:ArpSeedEnv, valueKind:ArpSeedValueKind) {
		super(seedName, key, env);
		if (value == null) throw "value must be nonnull";
		this.value = value;
		this.valueKind = valueKind;
	}
}

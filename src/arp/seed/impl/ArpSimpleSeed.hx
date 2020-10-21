package arp.seed.impl;

import arp.seed.ArpSeedValueKind;

class ArpSimpleSeed extends ArpSeed {

	private var _valueKind:ArpSeedValueKind;

	public function new(seedName:String, key:String, value:String, env:ArpSeedEnv, valueKind:ArpSeedValueKind) {
		super(seedName, key, env);
		if (value == null) throw "value must be nonnull";
		this.value = value;
		this.isSimple = true;
		this._valueKind = valueKind;
	}

	override private function get_valueKind():ArpSeedValueKind return this._valueKind;
}

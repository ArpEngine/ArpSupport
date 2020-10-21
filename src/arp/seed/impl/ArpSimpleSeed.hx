package arp.seed.impl;

import arp.iterators.SingleIterator;
import arp.seed.ArpSeedValueKind;

class ArpSimpleSeed extends ArpSeed {

	private static var emptyChildren:Array<ArpSeed> = [];

	private var _value:String;
	private var _valueKind:ArpSeedValueKind;

	public function new(typeName:String, key:String, value:String, env:ArpSeedEnv, valueKind:ArpSeedValueKind) {
		super(typeName);
		if (value == null) throw "value must be nonnull";
		this.key = key;
		this.env = env;
		this._value = value;
		this._valueKind = valueKind;
	}

	override private function get_isSimple():Bool return true;
	override private function get_value():String return this._value;
	override private function get_valueKind():ArpSeedValueKind return this._valueKind;

	override private function get_className():String return null;
	override private function get_name():String return null;
	override private function get_heat():String return null;

	override inline public function iterator():Iterator<ArpSeed> return new SingleIterator(this);
}

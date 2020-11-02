package arp.seed;

import arp.utils.ArpIdGenerator;
import arp.ds.access.IListAmend.IListAmendCursor;
import arp.ds.impl.ArrayList;
import arp.seed.sources.IArpSeedSource;

abstract ArpSeedBuilder(ArpSeed) {

	public var seedName(get, set):String;
	private function get_seedName():String return this.seedName;
	private function set_seedName(value:String):String return @:privateAccess this.seedName = value;
	public var key(get, set):String;
	private function get_key():String return this.key;
	private function set_key(value:String):String return @:privateAccess this.key = value;
	public var env(get, set):ArpSeedEnv;
	private function get_env():ArpSeedEnv return this.env;
	private function set_env(value:ArpSeedEnv):ArpSeedEnv return @:privateAccess this.env = value;

	public var className(get, set):Null<String>;
	private function get_className():Null<String> return this.className;
	private function set_className(value:Null<String>):Null<String> return @:privateAccess this.className = value;
	public var name(get, set):Null<String>;
	private function get_name():Null<String> return this.name;
	private function set_name(value:Null<String>):Null<String> return @:privateAccess this.name = value;
	public var heat(get, set):Null<String>;
	private function get_heat():Null<String> return this.heat;
	private function set_heat(value:Null<String>):Null<String> return @:privateAccess this.heat = value;

	public var maybeRef(get, set):Bool;
	private function get_maybeRef():Bool return this.maybeRef;
	private function set_maybeRef(value:Bool):Bool return @:privateAccess this.maybeRef = value;
	public var simpleValue(get, set):Null<String>;
	private function get_simpleValue():Null<String> return @:privateAccess this.simpleValue;
	private function set_simpleValue(value:Null<String>):Null<String> return @:privateAccess this.simpleValue = value;
	public var children(get, set):Null<Array<ArpSeed>>;
	private function get_children():Null<Array<ArpSeed>> return @:privateAccess this.children;
	private function set_children(value:Null<Array<ArpSeed>>):Null<Array<ArpSeed>> return @:privateAccess this.children = value;

	public var source(get, set):Null<IArpSeedSource>;
	private function get_source():Null<IArpSeedSource> return this.source;
	private function set_source(value:Null<IArpSeedSource>):Null<IArpSeedSource> return @:privateAccess this.source = value;

	public var value(get, set):Null<String>;
	private function get_value():Null<String> return this.value;
	private function set_value(value:Null<String>):Null<String> {
		return if (children != null) {
			var idGen:ArpIdGenerator = new ArpIdGenerator();
			for (child in children) {
				if (@:privateAccess child.seedName == "value") return @:privateAccess child.simpleValue = value;
				idGen.useId(child.key);
			}
			children.push(ArpSeed.createSimple("value", null, value, env).withSource(source));
			return value;
		} else {
			return simpleValue = value;
		}
	}

	private function new(seed:ArpSeed) this = seed;

	public static function fromSeedCopy(seed:ArpSeed):ArpSeedBuilder return new ArpSeedBuilder(seed);
	public static function fromSeed(seed:ArpSeed):ArpSeedBuilder return fromSeedCopy(seed.deepCopy());

	public function keyGen():ArpIdGenerator {
		var result:ArpIdGenerator = new ArpIdGenerator();
		if (children != null) {
			for (child in children) result.useId(child.key);
		}
		return result;
	}

	public function nextKey():String {
		var keyGen:ArpIdGenerator = keyGen();
		return keyGen.next();
	}

	public function amend():Iterator<IListAmendCursor<ArpSeed>> {
		var list:ArrayList<ArpSeed> = new ArrayList<ArpSeed>();
		@:privateAccess list.value = this.children;
		return list.amend();
	}

	public function toSeed():ArpSeed return this;
}

package arp.seed;

import arp.ds.access.IListAmend.IListAmendCursor;
import arp.ds.impl.ArrayList;
import arp.seed.sources.IArpSeedSource;

abstract ArpSeedBuilder(ArpSeed) {

	public var seedName(get, set):String;
	inline private function get_seedName():String return this.seedName;
	inline private function set_seedName(value:String):String return @:privateAccess this.seedName = value;
	public var key(get, set):String;
	inline private function get_key():String return this.key;
	inline private function set_key(value:String):String return @:privateAccess this.key = value;
	public var env(get, set):ArpSeedEnv;
	inline private function get_env():ArpSeedEnv return this.env;
	inline private function set_env(value:ArpSeedEnv):ArpSeedEnv return @:privateAccess this.env = value;

	public var className(get, set):Null<String>;
	inline private function get_className():Null<String> return this.className;
	inline private function set_className(value:Null<String>):Null<String> return @:privateAccess this.className = value;
	public var name(get, set):Null<String>;
	inline private function get_name():Null<String> return this.name;
	inline private function set_name(value:Null<String>):Null<String> return @:privateAccess this.name = value;
	public var heat(get, set):Null<String>;
	inline private function get_heat():Null<String> return this.heat;
	inline private function set_heat(value:Null<String>):Null<String> return @:privateAccess this.heat = value;

	public var maybeRef(get, set):Bool;
	inline private function get_maybeRef():Bool return this.maybeRef;
	inline private function set_maybeRef(value:Bool):Bool return @:privateAccess this.maybeRef = value;
	public var simpleValue(get, set):Null<String>;
	inline private function get_simpleValue():Null<String> return @:privateAccess this.simpleValue;
	inline private function set_simpleValue(value:Null<String>):Null<String> return @:privateAccess this.simpleValue = value;
	public var children(get, set):Null<Array<ArpSeed>>;
	inline private function get_children():Null<Array<ArpSeed>> return @:privateAccess this.children;
	inline private function set_children(value:Null<Array<ArpSeed>>):Null<Array<ArpSeed>> return @:privateAccess this.children = value;

	public var source(get, set):Null<IArpSeedSource>;
	inline private function get_source():Null<IArpSeedSource> return this.source;
	inline private function set_source(value:Null<IArpSeedSource>):Null<IArpSeedSource> return @:privateAccess this.source = value;

	public var value(get, set):Null<String>;
	inline private function get_value():Null<String> return this.value;
	private function set_value(value:Null<String>):Null<String> {
		return if (children != null) {
			for (child in children) {
				if (@:privateAccess child.seedName == "value") return @:privateAccess child.simpleValue = value;
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

	public function amend():Iterator<IListAmendCursor<ArpSeed>> {
		var list:ArrayList<ArpSeed> = new ArrayList<ArpSeed>();
		@:privateAccess list.value = children;
		return list.amend();
	}

	public function append(seed:ArpSeed):Void {
		if (children == null) children = [];
		children.push(seed);
	}

	public function prepend(seed:ArpSeed):Void {
		if (children == null) children = [];
		children.unshift(seed);
	}

	public function remove(seed:ArpSeed):Bool {
		return if (children == null) false else children.remove(seed);
	}

	public function toSeed():ArpSeed return this;
}

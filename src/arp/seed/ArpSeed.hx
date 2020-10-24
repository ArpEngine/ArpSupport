package arp.seed;

import arp.iterators.SimpleArrayIterator;
import arp.iterators.SingleIterator;
import arp.seed.readers.ArpCsvSeedReader;
import arp.seed.readers.ArpTableSeedReader;
import arp.seed.readers.ArpTsvSeedReader;
import arp.seed.readers.ArpXmlSeedReader;
import haxe.io.Bytes;

class ArpSeed {

	public var seedName(default, null):String;
	public var key(default, null):String;
	public var env(default, null):ArpSeedEnv;

	public var className(default, null):Null<String> = null;
	public var name(default, null):Null<String> = null;
	public var heat(default, null):Null<String> = null;

	public var maybeRef:Bool = false;
	@:deprecated("use maybeRef")
	public var valueKind(default, null):ArpSeedValueKind = ArpSeedValueKind.Literal;
	private var simpleValue(default, null):Null<String>;
	private var children:Null<Array<ArpSeed>>;

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

	public var value(get, never):Null<String>;
	private function get_value():Null<String> {
		return if (this.children != null) {
			for (child in this.childrenWithEnv) if (child.seedName == "value") return child.simpleValue;
			return null;
		} else {
			simpleValue;
		}
	}
	public function iterator():Iterator<ArpSeed> return if (children == null) new SingleIterator(this) else new SimpleArrayIterator(this.childrenWithEnv);

	@:deprecated("use value != null")
	public var isSimple(get, never):Bool;
	private function get_isSimple():Bool return this.value != null;

	private function new(seedName:String, key:String, env:ArpSeedEnv) {
		this.seedName = seedName;
		this.key = key;
		this.env = env;
	}

	public static function createSimple(seedName:String, key:String, value:String, env:ArpSeedEnv, valueKind:ArpSeedValueKind):ArpSeed {
		var seed:ArpSeed = new ArpSeed(seedName, key, env);
		if (value == null) throw "value must be nonnull";
		seed.simpleValue = value;
		seed.valueKind = valueKind;
		seed.maybeRef = switch (valueKind) {case ArpSeedValueKind.Ambigious | ArpSeedValueKind.Reference: true; case _: false;}
		return seed;
	}

	public static function createComplex(seedName:String, className:String, name:String, key:String, heat:String, children:Array<ArpSeed>, env:ArpSeedEnv):ArpSeed {
		var seed:ArpSeed = new ArpSeed(seedName, key, env);

		seed.className = className;
		seed.name = name;
		seed.heat = heat;
		seed.children = children;
		if (children.length == 0) {
			seed.valueKind = ArpSeedValueKind.Empty;
		} else {
			seed.valueKind = ArpSeedValueKind.Complex;
		}
		seed.maybeRef = false;
		return seed;
	}

	inline public static function fromXmlBytes(bytes:Bytes, env:Null<ArpSeedEnv> = null):ArpSeed {
		return new ArpXmlSeedReader().parseXmlBytes(bytes, env);
	}

	inline public static function fromXmlString(xmlString:String, env:Null<ArpSeedEnv> = null):ArpSeed {
		return new ArpXmlSeedReader().parseXmlString(xmlString, env);
	}

	public static function fromXml(xml:Xml, env:ArpSeedEnv = null):ArpSeed {
		return new ArpXmlSeedReader().parse(xml, env);
	}

	inline public static function fromCsvBytes(bytes:Bytes, lexicalType:Null<String> = null, env:Null<ArpSeedEnv> = null):ArpSeed {
		return new ArpCsvSeedReader().parseCsvBytes(bytes, lexicalType, env);
	}

	inline public static function fromCsvString(csvString:String, lexicalType:Null<String> = null, env:Null<ArpSeedEnv> = null):ArpSeed {
		return new ArpCsvSeedReader().parseCsvString(csvString, lexicalType, env);
	}

	inline public static function fromTsvBytes(bytes:Bytes, lexicalType:Null<String> = null, env:Null<ArpSeedEnv> = null):ArpSeed {
		return new ArpTsvSeedReader().parseTsvBytes(bytes, lexicalType, env);
	}

	inline public static function fromTsvString(csvString:String, lexicalType:Null<String> = null, env:Null<ArpSeedEnv> = null):ArpSeed {
		return new ArpTsvSeedReader().parseTsvString(csvString, lexicalType, env);
	}

	public static function fromTable(table:Array<Array<String>>, lexicalType:Null<String> = null, env:Null<ArpSeedEnv> = null):ArpSeed {
		return new ArpTableSeedReader().parse(table, lexicalType, env);
	}

	public static function isSpecialAttrName(attrName:String):Bool {
		return switch (attrName) {
			case "type" | "class" |"name" | "id" | "ref" | "heat" | "key":
				true;
			case _: // "value" is treated as child seed
				false;
		}
	}
}

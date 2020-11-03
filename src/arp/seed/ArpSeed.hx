package arp.seed;

import arp.iterators.SimpleArrayIterator;
import arp.iterators.SingleIterator;
import arp.seed.builder.ArpSeedWithoutSource;
import arp.seed.readers.ArpCsvSeedReader;
import arp.seed.readers.ArpTableSeedReader;
import arp.seed.readers.ArpTsvSeedReader;
import arp.seed.readers.ArpXmlSeedReader;
import arp.seed.sources.IArpSeedSource;
import haxe.io.Bytes;

class ArpSeed {

	public var seedName(default, null):String;
	public var key(default, null):Null<String>;
	public var env(default, null):ArpSeedEnv;

	public var className(default, null):Null<String> = null;
	public var name(default, null):Null<String> = null;
	public var heat(default, null):Null<String> = null;

	public var maybeRef:Bool = false;
	private var simpleValue(default, null):Null<String>;
	private var children:Null<Array<ArpSeed>>;

	public var source(default, null):IArpSeedSource;

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

	inline public function keyOrAuto(autoKey:String):String return if (key != null) key else autoKey;

	private function new(seedName:String, key:Null<String>, env:ArpSeedEnv) {
		this.seedName = seedName;
		this.key = key;
		this.env = env;
	}

	public static function createVerbatim(seedName:String, key:Null<String>, value:String, env:ArpSeedEnv):ArpSeedWithoutSource {
		var seed:ArpSeed = new ArpSeed(seedName, key, env);
		if (value == null) throw "value must be nonnull";
		seed.simpleValue = value;
		seed.maybeRef = false;
		return seed;
	}

	public static function createSimple(seedName:String, key:Null<String>, value:String, env:ArpSeedEnv):ArpSeedWithoutSource {
		var seed:ArpSeed = new ArpSeed(seedName, key, env);
		if (value == null) throw "value must be nonnull";
		seed.simpleValue = value;
		seed.maybeRef = true;
		return seed;
	}

	public static function createComplex(seedName:String, className:String, name:String, key:Null<String>, heat:String, children:Array<ArpSeed>, env:ArpSeedEnv):ArpSeedWithoutSource {
		var seed:ArpSeed = new ArpSeed(seedName, key, env);

		seed.className = className;
		seed.name = name;
		seed.heat = heat;
		seed.children = children;
		seed.maybeRef = false;
		return seed;
	}

	public function copy(withSource:Bool = false):ArpSeed {
		var result:ArpSeed = this.cloneSelf(withSource);
		if (this.children != null) result.children = this.children.copy();
		return result;
	}

	public function deepCopy(withSource:Bool = false):ArpSeed {
		var result:ArpSeed = this.cloneSelf(withSource);
		if (this.children != null) {
			result.children = [for (child in this.children) child.deepCopy(withSource)];
		}
		return result;
	}

	inline private function cloneSelf(withSource:Bool):ArpSeed {
		var result:ArpSeed = new ArpSeed(this.seedName, this.key, this.env);
		result.className = this.className;
		result.name = this.name;
		result.heat = this.heat;

		result.maybeRef = this.maybeRef;
		result.simpleValue = this.simpleValue;
		if (withSource) result.source = this.source;
		return result;
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

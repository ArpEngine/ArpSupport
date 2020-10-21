package arp.seed;

import arp.seed.readers.ArpTableSeedReader;
import arp.seed.readers.ArpTsvSeedReader;
import arp.seed.readers.ArpCsvSeedReader;
import arp.seed.readers.ArpXmlSeedReader;
import haxe.io.Bytes;

class ArpSeed {

	public var seedName(default, null):String;
	public var key(default, null):String;
	public var env(default, null):ArpSeedEnv;

	public var value(default, null):Null<String>;
	public var valueKind(get, never):ArpSeedValueKind;
	public var isSimple(default, null):Bool = true;

	public var className(default, null):Null<String> = null;
	public var name(default, null):Null<String> = null;
	public var heat(default, null):Null<String> = null;
	public function iterator():Iterator<ArpSeed> throw "not implemented";

	private function new(seedName:String, key:String, env:ArpSeedEnv) {
		this.seedName = seedName;
		this.key = key;
		this.env = env;
	}

	private function get_valueKind():ArpSeedValueKind throw "not implemented";

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

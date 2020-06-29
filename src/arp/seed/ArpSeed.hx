package arp.seed;

import haxe.io.Bytes;

class ArpSeed {

	public var seedName(default, null):String;
	public var key(default, null):String;
	public var env(default, null):ArpSeedEnv;

	public var value(get, never):String;
	public var valueKind(get, never):ArpSeedValueKind;
	public var isSimple(get, never):Bool;

	public var className(get, never):String;
	public var name(get, never):String;
	public var heat(get, never):String;
	public function iterator():Iterator<ArpSeed> throw "not implemented";

	private function new(seedName:String) {
		this.seedName = seedName;
	}

	private function get_value():String throw "not implemented";
	private function get_valueKind():ArpSeedValueKind throw "not implemented";
	private function get_isSimple():Bool throw "not implemented";

	private function get_className():String throw "not implemented";
	private function get_name():String throw "not implemented";
	private function get_heat():String throw "not implemented";

	inline public static function fromXmlBytes(bytes:Bytes, env:ArpSeedEnv = null):ArpSeed {
		return new ArpXmlSeedReader().parseXmlBytes(bytes, env);
	}

	inline public static function fromXmlString(xmlString:String, env:ArpSeedEnv = null):ArpSeed {
		return new ArpXmlSeedReader().parseXmlString(xmlString, env);
	}

	public static function fromXml(xml:Xml, env:ArpSeedEnv = null):ArpSeed {
		return new ArpXmlSeedReader().parse(xml, env);
	}

	inline public static function fromCsvBytes(bytes:Bytes, lexicalType:String = null, env:ArpSeedEnv = null):ArpSeed {
		return new ArpCsvSeedReader().parseCsvBytes(bytes, lexicalType, env);
	}

	inline public static function fromCsvString(csvString:String, lexicalType:String = null, env:ArpSeedEnv = null):ArpSeed {
		return new ArpCsvSeedReader().parseCsvString(csvString, lexicalType, env);
	}

	inline public static function fromTsvBytes(bytes:Bytes, lexicalType:String = null, env:ArpSeedEnv = null):ArpSeed {
		return new ArpTsvSeedReader().parseTsvBytes(bytes, lexicalType, env);
	}

	inline public static function fromTsvString(csvString:String, lexicalType:String = null, env:ArpSeedEnv = null):ArpSeed {
		return new ArpTsvSeedReader().parseTsvString(csvString, lexicalType, env);
	}

	public static function fromTable(table:Array<Array<String>>, lexicalType:String = null, env:ArpSeedEnv = null):ArpSeed {
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

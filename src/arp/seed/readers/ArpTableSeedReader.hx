package arp.seed.readers;

import arp.utils.ArpIdGenerator;

class ArpTableSeedReader {

	/*
		ArpTableSeedReader spec:
		- Columns:
		  - All keyword columns are ignored
		  - All non-keyword columns are Ambigious ArpSimpleSeed
		  - Columns are named by header
		- Rows:
		  - Each row is represented by ArpComplexSeed
	 */

	inline public function new() {
	}

	inline public function parse(table:Array<Array<String>>, lexicalType:String = null, env:ArpSeedEnv = null):ArpSeed {
		if (env == null) env = ArpSeedEnv.empty();
		return parseInternal(table, lexicalType, ArpIdGenerator.first, env);
	}

	private function parseInternal(table:Array<Array<String>>, lexicalType:String, uniqId:String, env:ArpSeedEnv):ArpSeed {
		if (table.length == 0) return null;

		var header:Array<String> = table.shift();

		var idGen:ArpIdGenerator = new ArpIdGenerator();
		var seeds:Array<ArpSeed> = [];
		for (row in table) {
			var typeName:String = lexicalType;
			var className:String = null;
			var name:String = null;
			var heat:String = null;
			var key:String = idGen.next();
			var children:Array<ArpSeed> = [];

			for (i in 0...header.length) {
				var attr:String = row[i];
				if (attr == "" || attr == null) continue;
				var attrName:String = header[i];
				switch (attrName) {
					case "type":
						typeName = attr;
					case "class":
						className = attr;
					case "name", "id":
						name = attr;
					case "heat":
						heat = attr;
					case "key":
						key = attr;
					case _:
						// "value" is handled here
						// "ref" is not supported
						children.push(ArpSeed.createSimple(attrName, key, attr, env, ArpSeedValueKind.Ambigious));
				}
			}
			if (name == null) continue;
			seeds.push(ArpSeed.createComplex(typeName, className, name, key, heat, children, env));
		};

		// wrap with <data>
		return ArpSeed.createComplex("data", null, null, null, null, seeds, env);
	}
}

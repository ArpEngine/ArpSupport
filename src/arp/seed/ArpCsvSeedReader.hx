package arp.seed;

import haxe.io.Bytes;

class ArpCsvSeedReader extends ArpTableSeedReader {

	inline public function new() super();

	inline public function parseCsvBytes(bytes:Bytes, lexicalType:String = null, env:ArpSeedEnv = null):ArpSeed {
		return parseCsvString(bytes.toString(), lexicalType, env);
	}

	inline public function parseCsvString(csvString:String, lexicalType:String = null, env:ArpSeedEnv = null):ArpSeed {
#if thx.csv
		return parse(thx.csv.Csv.decode(csvString), lexicalType, env);
#elseif csv
		return parse(format.csv.Utf8Reader.parseCsv(csvString), lexicalType, env);
#else
		return parse([for (row in csvString.split("\n")) row.split(",")], lexicalType, env);
#end
	}
}

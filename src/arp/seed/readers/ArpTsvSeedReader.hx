package arp.seed.readers;

import haxe.io.Bytes;

class ArpTsvSeedReader extends ArpTableSeedReader {

	inline public function new() super();

	inline public function parseTsvBytes(bytes:Bytes, lexicalType:String = null, env:ArpSeedEnv = null):ArpSeed {
		return parseTsvString(bytes.toString(), lexicalType, env);
	}

	inline public function parseTsvString(csvString:String, lexicalType:String = null, env:ArpSeedEnv = null):ArpSeed {
#if thx.csv
		return parse(thx.csv.Tsv.decode(csvString), lexicalType, env);
#elseif csv
		return parse(format.csv.Utf8Reader.parseCsv(csvString, "\t"), lexicalType, env);
#else
		return parse([for (row in csvString.split("\n")) row.split("\t")], lexicalType, env);
#end
	}
}

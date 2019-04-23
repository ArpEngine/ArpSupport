package arp.persistable;

import haxe.Json;
import arp.persistable.MockPersistable;

import picotest.PicoAssert.*;

class JsonPersistIoCase {

	public static var JSON = {
		"obj": {
			"doubleValue": 0.5,
			"$1": 100,
			"intValue": 2,
			"booleanValue": true,
			"$0": false,
			"nameListValue": [
				"a",
				"b",
				"c"
			],
			"childValue": {
				"nameListValue": [
					"a",
					"b",
					"c"
				],
				"doubleValue": 0.5,
				"$1": 200,
				"$3": "222",
				"intValue": 1,
				"blobValue": "AAAAAAAAAAA=",
				"$4": "OA==",
				"booleanValue": false,
				"utfValue": "utf",
				"$0": true,
				"$2": 200.2
			},
			"$3": "111",
			"blobValue": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==",
			"$4": "NjQ=",
			"utfValue": "utf",
			"$2": 100.1
		}
	};

	public function new() {
	}

	public function testPersistFormat():Void {
		var output:JsonPersistOutput = new JsonPersistOutput();
		var obj:MockPersistable = new MockPersistable(true);
		output.writePersistable("obj", obj);
		assertJsonMatch(haxe.format.JsonPrinter.print(JSON), output.json);
	}
}

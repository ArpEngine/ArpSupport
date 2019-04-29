package arp.persistable;

import haxe.io.Bytes;
import arp.persistable.MockPersistable;
import picotest.PicoAssert.*;

class AnonPersistIoCase {

	public static var ANON = {
		"obj": {
			"doubleValue": 0.5,
			"$1": 100,
			"intValue": 2,
			"booleanValue": true,
			"$0": false,
			"childValue": {
				"doubleValue": 0.5,
				"$1": 200,
				"$3": "222",
				"intValue": 1,
				"blobValue": Bytes.alloc(8),
				"$4": Bytes.ofString("8"),
				"booleanValue": false,
				"utfValue": "utf",
				"$0": true,
				"$2": 200.2,
				"array": { "$0": "a0", "$1": "a1" }
			},
			"$3": "111",
			"blobValue": Bytes.alloc(64),
			"$4": Bytes.ofString("64"),
			"utfValue": "utf",
			"$2": 100.1,
			"array": { "$0": "a0", "$1": "a1" }
		}
	};

	public function new() {
	}

	public function testPersistFormat():Void {
		var output:AnonPersistOutput = new AnonPersistOutput();
		var obj:MockPersistable = new MockPersistable(true);
		output.writePersistable("obj", obj);
		assertMatch(ANON, output.data);
	}
}

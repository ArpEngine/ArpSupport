package arp.persistable;

import arp.persistable.MockPersistable;
import haxe.io.Bytes;
import picotest.PicoAssert.*;

class ArrayPersistIoCase {

	public static var ARRAY:Array<Dynamic> = [
		[
			"obj",
			[
				["booleanValue", true],
				["intValue", 2],
				["doubleValue", 0.5],
				["utfValue", "utf"],
				["blobValue", Bytes.alloc(64)],
				["childValue", [
					["booleanValue", false],
					["intValue", 1],
					["doubleValue", 0.5],
					["utfValue", "utf"],
					["blobValue", Bytes.alloc(8)],
					true,
					200,
					200.2,
					"222",
					Bytes.ofString("8"),
					["array", ["a0", "a1"]]
				]],
				false,
				100,
				100.1,
				"111",
				Bytes.ofString("64"),
				["array", ["a0", "a1"]]
			]
		]
	]
	;

	public function new() {
	}

	public function testPersistFormat():Void {
		var output:ArrayPersistOutput = new ArrayPersistOutput();
		var obj:MockPersistable = new MockPersistable(true);
		output.writePersistable("obj", obj);
		assertMatch(ARRAY, output.data);
	}
}

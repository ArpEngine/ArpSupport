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
				"$2": 200.2,
				"array": ["a0", "a1"]
			},
			"$3": "111",
			"blobValue": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==",
			"$4": "NjQ=",
			"utfValue": "utf",
			"$2": 100.1,
			"array": ["a0", "a1"]
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

	public function testAnonIntoAnon():Void {
		var output:JsonPersistOutput = new JsonPersistOutput();
		output.writeEnter("obj");
		output.writeUtf("name", "value");
		output.writeExit();
		assertMatch({ obj: { name: "value" } }, haxe.format.JsonParser.parse(output.json));
	}

	public function testAnonFromAnon():Void {
		var input:JsonPersistInput = new JsonPersistInput(haxe.format.JsonPrinter.print({ obj: { name: "value" } }));
		input.readEnter("obj");
		var name = input.readUtf("name");
		input.readExit();
		assertMatch("value", name);
	}

	public function testAnonIntoArray():Void {
		var output:JsonPersistOutput = new JsonPersistOutput();
		output.writeListEnter("obj");
		output.pushUtf("value");
		output.writeExit();
		assertMatch({ obj: ["value"] }, haxe.format.JsonParser.parse(output.json));
	}

	public function testAnonFromArray():Void {
		var input:JsonPersistInput = new JsonPersistInput(haxe.format.JsonPrinter.print({ obj: ["value"] }));
		input.readListEnter("obj");
		var name = input.nextUtf();
		input.readExit();
		assertMatch("value", name);
	}

	public function testArrayIntoAnon():Void {
		var output:JsonPersistOutput = new JsonPersistOutput();
		output.writeListEnter("array");
		output.writeEnter("obj");
		output.writeUtf("name", "value");
		output.writeExit();
		output.writeExit();
		assertMatch(untyped { array: [["obj", {name: "value"} ]] }, haxe.format.JsonParser.parse(output.json));
	}

	public function testArrayFromAnon():Void {
		var input:JsonPersistInput = new JsonPersistInput(haxe.format.JsonPrinter.print(untyped { array: [["obj", {name: "value"} ]] }));
		input.readListEnter("array");
		input.readEnter("obj");
		var name = input.readUtf("name");
		input.readExit();
		input.readExit();
		assertMatch("value", name);
	}

	public function testArrayIntoArray():Void {
		var output:JsonPersistOutput = new JsonPersistOutput();
		output.writeListEnter("array");
		output.writeListEnter("a");
		output.pushUtf("value");
		output.writeExit();
		assertMatch(untyped { array: [["a", ["value"]]] }, haxe.format.JsonParser.parse(output.json));
	}

	public function testArrayFromArray():Void {
		var input:JsonPersistInput = new JsonPersistInput(haxe.format.JsonPrinter.print(untyped { array: [["a", ["value"]]] }));
		input.readListEnter("array");
		input.readListEnter("a");
		var name = input.nextUtf();
		input.readExit();
		input.readExit();
		assertMatch("value", name);
	}
}

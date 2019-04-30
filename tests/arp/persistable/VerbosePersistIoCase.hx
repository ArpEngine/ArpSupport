package arp.persistable;

import arp.persistable.MockPersistable;
import picotest.PicoAssert.*;

class VerbosePersistIoCase {

	public static var DATA = [
		"0 :writeEnter:obj",
		"1   :writeBool:booleanValue:true",
		"1   :writeInt32:intValue:2",
		"1   :writeDouble:doubleValue:0.5",
		"1   :writeUtf:utfValue:utf",
		"1   :writeBlob:blobValue:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
		"1   :writeEnter:childValue",
		"2     :writeBool:booleanValue:false",
		"2     :writeInt32:intValue:1",
		"2     :writeDouble:doubleValue:0.5",
		"2     :writeUtf:utfValue:utf",
		"2     :writeBlob:blobValue:0000000000000000",
		"2     :pushBool:true",
		"2     :pushInt32:200",
		"2     :pushDouble:200.2",
		"2     :pushUtf:222",
		"2     :pushBlob:38",
		"2     :writeListEnter:array",
		"3       :pushUtf:a0",
		"3       :pushUtf:a1",
		"2     :writeExit:",
		"1   :writeExit:",
		"1   :pushBool:false",
		"1   :pushInt32:100",
		"1   :pushDouble:100.1",
		"1   :pushUtf:111",
		"1   :pushBlob:3634",
		"1   :writeListEnter:array",
		"2     :pushUtf:a0",
		"2     :pushUtf:a1",
		"1   :writeExit:",
		"0 :writeExit:"
	];

	public function new() {
	}

	public function testPersistFormat():Void {
		var output:VerbosePersistOutput = new VerbosePersistOutput();
		var obj:MockPersistable = new MockPersistable(true);
		output.writePersistable("obj", obj);
		assertMatch(DATA, output.data);
	}
}

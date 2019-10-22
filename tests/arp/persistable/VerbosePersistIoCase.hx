package arp.persistable;

import arp.persistable.MockPersistable;
import picotest.PicoAssert.*;

class VerbosePersistIoCase {

	public static var DATA = [
		"   1:0 :writeEnter:obj",
		"   2:1   :writeBool:booleanValue:true",
		"   3:1   :writeInt32:intValue:2",
		"   4:1   :writeDouble:doubleValue:0.5",
		"   5:1   :writeUtf:utfValue:utf",
		"   6:1   :writeBlob:blobValue:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
		"   7:1   :writeEnter:childValue",
		"   8:2     :writeBool:booleanValue:false",
		"   9:2     :writeInt32:intValue:1",
		"  10:2     :writeDouble:doubleValue:0.5",
		"  11:2     :writeUtf:utfValue:utf",
		"  12:2     :writeBlob:blobValue:0000000000000000",
		"  13:2     :pushBool:true",
		"  14:2     :pushInt32:200",
		"  15:2     :pushDouble:200.2",
		"  16:2     :pushUtf:222",
		"  17:2     :pushBlob:38",
		"  18:2     :writeListEnter:array",
		"  19:3       :pushUtf:a0",
		"  20:3       :pushUtf:a1",
		"  21:2     :writeExit:",
		"  22:1   :writeExit:",
		"  23:1   :pushBool:false",
		"  24:1   :pushInt32:100",
		"  25:1   :pushDouble:100.1",
		"  26:1   :pushUtf:111",
		"  27:1   :pushBlob:3634",
		"  28:1   :writeListEnter:array",
		"  29:2     :pushUtf:a0",
		"  30:2     :pushUtf:a1",
		"  31:1   :writeExit:",
		"  32:0 :writeExit:"
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

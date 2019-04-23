package arp.persistable;

import arp.io.OutputWrapper;
import haxe.io.BytesOutput;
import arp.persistable.MockPersistable;

import picotest.PicoAssert.*;

class PackedPersistIoCase {

	public static var HEX = "03000000010000006101000000620100000063ff02000000000000000000e03f030000007574664000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030000000100000061010000006201000000630001000000000000000000e03f03000000757466080000000000000000000000ffc800000066666666660669400300000032323201000000380064000000666666666606594003000000313131020000003634";
	public function new() {
	}

	public function testPersistOutput():Void {
		var bytesOutput:BytesOutput = new BytesOutput();
		var output:PackedPersistOutput = new PackedPersistOutput(new OutputWrapper(bytesOutput));
		var obj:MockPersistable = new MockPersistable(true);
		output.writePersistable("obj", obj);
		assertEquals(HEX, bytesOutput.getBytes().toHex());
	}
}

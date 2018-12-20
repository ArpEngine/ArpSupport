package arp.io;

import haxe.Int64;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;
import haxe.io.Bytes;

import org.hamcrest.Matchers.*;
import picotest.PicoAssert.*;

class BytesToolCase {

	public function testGetDoubleBE():Void {
		var output:BytesOutput = new BytesOutput();
		output.bigEndian = true;
		output.writeDouble(12.34);
		output.writeDouble(-56.78);
		output.writeDouble(Math.NaN);
		output.writeDouble(Math.NEGATIVE_INFINITY);
		var bytes:Bytes = output.getBytes();
		assertMatch(closeTo(12.34, 0.01), BytesTool.getDoubleBE(bytes, 0));
		assertMatch(closeTo(-56.78, 0.01), BytesTool.getDoubleBE(bytes, 8));
		assertMatch(Math.NaN, BytesTool.getDoubleBE(bytes, 16));
		assertMatch(Math.NEGATIVE_INFINITY, BytesTool.getDoubleBE(bytes, 24));
	}

	public function testGetFloatBE():Void {
		var output:BytesOutput = new BytesOutput();
		output.bigEndian = true;
		output.writeFloat(12.34);
		output.writeFloat(-56.78);
		output.writeFloat(Math.NaN);
		output.writeFloat(Math.NEGATIVE_INFINITY);
		var bytes:Bytes = output.getBytes();
		assertMatch(closeTo(12.34, 0.01), BytesTool.getFloatBE(bytes, 0));
		assertMatch(closeTo(-56.78, 0.01), BytesTool.getFloatBE(bytes, 4));
		assertMatch(Math.NaN, BytesTool.getFloatBE(bytes, 8));
		assertMatch(Math.NEGATIVE_INFINITY, BytesTool.getFloatBE(bytes, 12));
	}

	public function testSetDoubleBE():Void {
		var bytes = Bytes.alloc(32);
		BytesTool.setDoubleBE(bytes, 0, 12.34);
		BytesTool.setDoubleBE(bytes, 8, -56.78);
		BytesTool.setDoubleBE(bytes, 16, Math.NaN);
		BytesTool.setDoubleBE(bytes, 24, Math.NEGATIVE_INFINITY);
		var input:BytesInput = new BytesInput(bytes);
		input.bigEndian = true;
		assertMatch(closeTo(12.34, 0.01), input.readDouble());
		assertMatch(closeTo(-56.78, 0.01), input.readDouble());
		assertMatch(Math.NaN, input.readDouble());
		assertMatch(Math.NEGATIVE_INFINITY, input.readDouble());
	}

	public function testSetFloatBE():Void {
		var bytes = Bytes.alloc(16);
		BytesTool.setFloatBE(bytes, 0, 12.34);
		BytesTool.setFloatBE(bytes, 4, -56.78);
		BytesTool.setFloatBE(bytes, 8, Math.NaN);
		BytesTool.setFloatBE(bytes, 12, Math.NEGATIVE_INFINITY);
		var input:BytesInput = new BytesInput(bytes);
		input.bigEndian = true;
		assertMatch(closeTo(12.34, 0.01), input.readFloat());
		assertMatch(closeTo(-56.78, 0.01), input.readFloat());
		assertMatch(Math.NaN, input.readFloat());
		assertMatch(Math.NEGATIVE_INFINITY, input.readFloat());
	}

	public function testGetUInt16BE():Void {
		var output:BytesOutput = new BytesOutput();
		output.bigEndian = true;
		output.writeUInt16(123);
		output.writeUInt16(4567);
		var bytes:Bytes = output.getBytes();
		assertMatch(123, BytesTool.getUInt16BE(bytes, 0));
		assertMatch(4567, BytesTool.getUInt16BE(bytes, 2));
	}

	public function testSetUInt16BE():Void {
		var bytes = Bytes.alloc(4);
		BytesTool.setUInt16BE(bytes, 0, 123);
		BytesTool.setUInt16BE(bytes, 2, 4567);
		var input:BytesInput = new BytesInput(bytes);
		input.bigEndian = true;
		assertMatch(123, input.readUInt16());
		assertMatch(4567, input.readUInt16());
	}

	public function testGetInt32BE():Void {
		var output:BytesOutput = new BytesOutput();
		output.bigEndian = true;
		output.writeInt32(0x12345678);
		output.writeInt32(0x9abcdef0);
		var bytes:Bytes = output.getBytes();
		assertMatch(0x12345678, BytesTool.getInt32BE(bytes, 0));
		assertMatch(0x9abcdef0, BytesTool.getInt32BE(bytes, 4));
	}

	public function testGetInt64BE():Void {
		var output:BytesOutput = new BytesOutput();
		output.bigEndian = true;
		output.writeInt32(0x1234567);
		output.writeInt32(0x89abcdef);
		output.writeInt32(0xfedcba8);
		output.writeInt32(0x76543210);
		var bytes:Bytes = output.getBytes();
		assertMatch(Std.string(Int64.make(0x1234567, 0x89abcdef)), Std.string(BytesTool.getInt64BE(bytes, 0)));
		assertMatch(Std.string(Int64.make(0xfedcba8, 0x76543210)), Std.string(BytesTool.getInt64BE(bytes, 8)));
	}

	public function testSetInt32BE():Void {
		var bytes = Bytes.alloc(8);
		BytesTool.setInt32BE(bytes, 0, 0x12345678);
		BytesTool.setInt32BE(bytes, 4, 0x9abcdef0);
		var input:BytesInput = new BytesInput(bytes);
		input.bigEndian = true;
		assertMatch(0x12345678, input.readInt32());
		assertMatch(0x9abcdef0, input.readInt32());
	}

	public function testSetInt64BE():Void {
		var bytes = Bytes.alloc(16);
		BytesTool.setInt64BE(bytes, 0, Int64.make(0x1234567, 0x89abcdef));
		BytesTool.setInt64BE(bytes, 8, Int64.make(0xfedcba8, 0x76543210));
		var input:BytesInput = new BytesInput(bytes);
		input.bigEndian = true;
		assertMatch(0x1234567, input.readInt32());
		assertMatch(0x89abcdef, input.readInt32());
		assertMatch(0xfedcba8, input.readInt32());
		assertMatch(0x76543210, input.readInt32());
	}

	public function testToBytes():Void {
		var bytesData = [0x01, 0x02, 0x03, 0x04];
		var bytes = BytesTool.toBytes(bytesData);
		assertEquals(0x01, bytes.get(0));
		assertEquals(0x02, bytes.get(1));
		assertEquals(0x03, bytes.get(2));
		assertEquals(0x04, bytes.get(3));
	}

	public function testToArray():Void {
		var bytes = Bytes.alloc(4);
		bytes.set(0, 0x01);
		bytes.set(1, 0x02);
		bytes.set(2, 0x03);
		bytes.set(3, 0x04);
		var bytesData = BytesTool.toArray(bytes);
		assertEquals(0x01, bytesData[0]);
		assertEquals(0x02, bytesData[1]);
		assertEquals(0x03, bytesData[2]);
		assertEquals(0x04, bytesData[3]);
	}
}

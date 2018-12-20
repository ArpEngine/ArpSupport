package arp.io;

import arp.testParams.IoProviders.IInputProvider;
import haxe.io.Bytes;
import picotest.PicoAssert.*;

class InputWrapperCase {

	private var provider:IInputProvider;
	private var me:IInput;

	@Parameter
	public function setup(provider:IInputProvider):Void {
		this.provider = provider;
	}

	private var bytesData(never, set):Array<Int>;
	private function set_bytesData(value:Array<Int>):Array<Int> {
		me = this.provider.create(value);
		me.bigEndian = true;
		return value;
	}

	public function testReadBool():Void {
		this.bytesData = [-1, 0, 1, 2];
		assertEquals(true, me.readBool());
		assertEquals(false, me.readBool());
		assertEquals(true, me.readBool());
		assertEquals(true, me.readBool());
	}

	public function testReadInt8():Void {
		this.bytesData = [0, 1, 128, 255];
		assertEquals(0, me.readInt8());
		assertEquals(1, me.readInt8());
		assertEquals(-128, me.readInt8());
		assertEquals(-1, me.readInt8());
	}

	public function testReadInt16():Void {
		this.bytesData = [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef];
		assertEquals(0x123, me.readInt16());
		assertEquals(0x4567, me.readInt16());
		assertEquals(0xffff89ab, me.readInt16());
		assertEquals(0xffffcdef, me.readInt16());
	}

	public function testReadInt32():Void {
		this.bytesData = [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef];
		assertEquals(0x01234567, me.readInt32());
		assertEquals((0x89abcdef:Int), me.readInt32());
	}

	public function testReadUInt8():Void {
		this.bytesData = [0, 1, 128, 255];
		assertEquals(0, me.readUInt8());
		assertEquals(1, me.readUInt8());
		assertEquals(128, me.readUInt8());
		assertEquals(255, me.readUInt8());
	}

	public function testReadUInt16():Void {
		this.bytesData = [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef];
		assertEquals(0x123, me.readUInt16());
		assertEquals(0x4567, me.readUInt16());
		assertEquals(0x89ab, me.readUInt16());
		assertEquals(0xcdef, me.readUInt16());
	}

	public function testReadUInt32():Void {
		this.bytesData = [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef];
		assertEquals(0x01234567, me.readUInt32());
		assertEquals((0x89abcdef:UInt), me.readUInt32());
	}

	public function testReadBytes():Void {
		this.bytesData = [0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68];
		var b = Bytes.alloc(2);
		me.readBytes(b, 0, 2);
		assertEquals("6162", b.toHex());
		me.readBytes(b, 0, 1);
		assertEquals("6362", b.toHex());
		me.readBytes(b, 1, 1);
		assertEquals("6364", b.toHex());
	}

	public function testReadUtfBytes():Void {
		this.bytesData = [0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68];
		assertEquals("a", me.readUtfBytes(1));
		assertEquals("bc", me.readUtfBytes(2));
		assertEquals("def", me.readUtfBytes(3));
	}

	public function testReadBlob():Void {
		this.bytesData = [0x00, 0x00, 0x00, 0x02, 0x61, 0x62, 0x00, 0x00, 0x00, 0x04, 0x63, 0x64, 0x65, 0x66];
		assertEquals("ab", me.readBlob().toString());
		assertEquals("cdef", me.readBlob().toString());
	}

	public function testReadUtfBlob():Void {
		this.bytesData = [0x00, 0x00, 0x00, 0x02, 0x61, 0x62, 0x00, 0x00, 0x00, 0x04, 0x63, 0x64, 0x65, 0x66];
		assertEquals("ab", me.readUtfBlob());
		assertEquals("cdef", me.readUtfBlob());
	}

	public function testNextBytes(limit:Int = 0):Void {
		this.bytesData = [0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68];
		assertEquals("abcd", me.nextBytes(4).toString());
		assertEquals("efgh", me.nextBytes(8).toString());
	}
}

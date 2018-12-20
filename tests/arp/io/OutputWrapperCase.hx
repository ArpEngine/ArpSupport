package arp.io;

import arp.testParams.IoProviders.IOutputProvider;
import haxe.io.Bytes;
import picotest.PicoAssert.*;

class OutputWrapperCase {

	private var provider:IOutputProvider;
	private var me:IOutput;

	@Parameter
	public function setup(provider:IOutputProvider):Void {
		this.provider = provider;
		me = provider.create();
		me.bigEndian = true;
	}

	private var bytesData(get, never):Array<Int>;
	private function get_bytesData():Array<Int> return this.provider.bytesData();


	public function testWriteBool():Void {
		me.writeBool(true);
		me.writeBool(false);
		me.writeBool(true);
		me.writeBool(false);
		var b:Array<Int> = [255, 0, 255, 0];
		assertMatch(b, this.bytesData);
	}

	public function testWriteInt8():Void {
		me.writeInt8(0);
		me.writeInt8(1);
		/*me.writeInt8(128);*/
		me.writeInt8(-128);
		var b:Array<Int> = [0, 1, /*128,*/ 128];
		assertMatch(b, this.bytesData);
	}

	public function testWriteInt16():Void {
		me.writeInt16(0);
		me.writeInt16(1);
		/*me.writeInt16(0x8888);*/
		me.writeInt16(0xffffcccc);
		var b:Array<Int> = [0x00, 0x00, 0x00, 0x01, /*0x88, 0x88,*/ 0xcc, 0xcc];
		assertMatch(b, this.bytesData);
	}

	public function testWriteInt32():Void {
		me.writeInt32(0x1);
		me.writeInt32(0x89abcdef);
		var b:Array<Int> = [0x00, 0x00, 0x00, 0x01, 0x89, 0xab, 0xcd, 0xef];
		assertMatch(b, this.bytesData);
	}

	public function testWriteUInt8():Void {
		me.writeUInt8(0);
		me.writeUInt8(1);
		me.writeUInt8(128);
		me.writeUInt8(-128);
		var b:Array<Int> = [0, 1, 128, 128];
		assertMatch(b, this.bytesData);
	}

	public function testWriteUInt16():Void {
		me.writeUInt16(0);
		me.writeUInt16(1);
		me.writeUInt16(0x8888);
		/*me.writeUInt16(0xffffcccc);*/
		var b:Array<Int> = [0x00, 0x00, 0x00, 0x01, 0x88, 0x88/*, 0xcc, 0xcc*/];
		assertMatch(b, this.bytesData);
	}

	public function testWriteUInt32():Void {
		me.writeUInt32(0x1);
		me.writeUInt32(0x89abcdef);
		var b:Array<Int> = [0x00, 0x00, 0x00, 0x01, 0x89, 0xab, 0xcd, 0xef];
		assertMatch(b, this.bytesData);
	}

	public function testWriteBytes():Void {
		me.writeBytes(Bytes.ofString("ab"), 0, 2);
		me.writeBytes(Bytes.ofString("cdef"), 1, 2);
		var b:Array<Int> = [0x61, 0x62, 0x64, 0x65];
		assertMatch(b, this.bytesData);
	}

	public function testWriteUtfBytes():Void {
		me.writeUtfBytes("ab");
		me.writeUtfBytes("cdef");
		var b:Array<Int> = [0x61, 0x62, 0x63, 0x64, 0x65, 0x66];
		assertMatch(b, this.bytesData);
	}

	public function testWriteBlob():Void {
		me.writeBlob(Bytes.ofString("ab"));
		me.writeBlob(Bytes.ofString("cdef"));
		var b:Array<Int> = [0x00, 0x00, 0x00, 0x02, 0x61, 0x62, 0x00, 0x00, 0x00, 0x04, 0x63, 0x64, 0x65, 0x66];
		assertMatch(b, this.bytesData);
	}

	public function testWriteUtfBlob():Void {
		me.writeUtfBlob("ab");
		me.writeUtfBlob("cdef");
		var b:Array<Int> = [0x00, 0x00, 0x00, 0x02, 0x61, 0x62, 0x00, 0x00, 0x00, 0x04, 0x63, 0x64, 0x65, 0x66];
		assertMatch(b, this.bytesData);
	}
}

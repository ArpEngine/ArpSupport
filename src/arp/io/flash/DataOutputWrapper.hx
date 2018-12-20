package arp.io.flash;

#if (flash || openfl)

import flash.utils.Endian;
import flash.utils.IDataOutput;
import haxe.io.Bytes;

class DataOutputWrapper implements IOutput
{
	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return this.output.endian == Endian.BIG_ENDIAN;
	private function set_bigEndian(value:Bool):Bool {
		this.output.endian = value ? Endian.BIG_ENDIAN : Endian.LITTLE_ENDIAN;
		return value;
	}

	private var output:IDataOutput;

	public function new(output:IDataOutput) this.output = output;

	public function writeBool(value:Bool):Void this.output.writeByte(value ? 255 : 0);

	public function writeInt8(value:Int):Void this.output.writeByte(value);
	public function writeInt16(value:Int):Void this.output.writeShort(value);
	public function writeInt32(value:Int):Void this.output.writeInt(value);

	public function writeUInt8(value:UInt):Void this.output.writeByte(value);
	public function writeUInt16(value:UInt):Void this.output.writeShort(value);
	public function writeUInt32(value:UInt):Void this.output.writeUnsignedInt(cast value);

	public function writeFloat(value:Float):Void this.output.writeFloat(value);
	public function writeDouble(value:Float):Void this.output.writeDouble(value);

	public function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void {
		this.output.writeBytes(bytes.getData(), offset, length);
	}
	public function writeUtfBytes(value:String):Void {
		var bytes:Bytes = Bytes.ofString(value);
		this.writeBytes(bytes, 0, bytes.length);
	}

	public function writeBlob(bytes:Bytes):Void {
		this.output.writeInt(bytes.length);
		this.output.writeBytes(bytes.getData(), 0, bytes.length);
	}
	public function writeUtfBlob(value:String):Void {
		this.writeBlob(Bytes.ofString(value));
	}

	public function writeUtfString(value:Null<String>):Void {
		if (value == null) return this.output.writeInt(-1);
		this.writeBlob(Bytes.ofString(value));
	}
}

#end

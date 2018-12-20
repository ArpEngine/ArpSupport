package arp.io.flash;

#if (flash || openfl)

import flash.utils.ByteArray;
import flash.utils.Endian;
import flash.utils.IDataInput;
import haxe.io.Bytes;

class DataInputWrapper implements IInput {

	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return this.input.endian == Endian.BIG_ENDIAN;
	private function set_bigEndian(value:Bool):Bool {
		this.input.endian = value ? Endian.BIG_ENDIAN : Endian.LITTLE_ENDIAN;
		return value;
	}

	private var input:IDataInput;

	public function new(input:IDataInput) this.input = input;

	public function readBool():Bool return this.input.readByte() != 0;

	public function readInt8():Int return this.input.readByte();
	public function readInt16():Int return this.input.readShort();
	public function readInt32():Int return this.input.readInt();

	public function readUInt8():UInt return this.input.readUnsignedByte();
	public function readUInt16():UInt return this.input.readUnsignedShort();
	public function readUInt32():UInt return this.input.readUnsignedInt();

	public function readFloat():Float return this.input.readFloat();
	public function readDouble():Float return this.input.readDouble();

	public function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void {
		return this.input.readBytes(bytes.getData(), offset, length);
	}
	public function readUtfBytes(length:UInt):String {
		return this.input.readUTFBytes(length);
	}

	public function readBlob():Bytes {
		var len:Int = this.input.readInt();
		var byteArray:ByteArray = new ByteArray();
		this.input.readBytes(byteArray, 0, len);
		return Bytes.ofData(byteArray);
	}
	public function readUtfBlob():String {
		var length:Int = this.input.readInt();
		return this.input.readUTFBytes(length);
	}

	public function readUtfString():Null<String> {
		var length:Int = this.input.readInt();
		return length < 0 ? null : this.input.readUTFBytes(length);
	}

	public function nextBytes(limit:Int = 0):Bytes {
		var len:Int = this.input.bytesAvailable;
		if (len > limit) len = limit;
		var byteArray:ByteArray = new ByteArray();
		this.input.readBytes(byteArray, 0, len);
		return Bytes.ofData(byteArray);
	}

}

#end

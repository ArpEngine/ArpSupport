package arp.io;

import haxe.io.Bytes;
import haxe.io.Output;

class OutputWrapper extends OutputWrapperBase<Output> {
}

class OutputWrapperBase<T:Output> implements IOutput {

	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return this.output.bigEndian;
	private function set_bigEndian(value:Bool):Bool return this.output.bigEndian = value;

	private var output:T;

	public function new(output:T) this.output = output;

	public function writeBool(value:Bool):Void this.output.writeByte(value ? 255 : 0);

	public function writeInt8(value:Int):Void this.output.writeInt8(value);
	public function writeInt16(value:Int):Void this.output.writeInt16(value);
	public function writeInt32(value:Int):Void this.output.writeInt32(value);

	public function writeUInt8(value:UInt):Void this.output.writeByte(value);
	public function writeUInt16(value:UInt):Void this.output.writeUInt16(value);
	public function writeUInt32(value:UInt):Void this.output.writeInt32(cast value);

	public function writeFloat(value:Float):Void this.output.writeFloat(value);
	public function writeDouble(value:Float):Void this.output.writeDouble(value);

	public function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void {
		this.output.writeFullBytes(bytes, offset, length);
	}
	public function writeUtfBytes(value:String):Void {
		var bytes:Bytes = Bytes.ofString(value);
		this.writeBytes(bytes, 0, bytes.length);
	}

	public function writeBlob(bytes:Bytes):Void {
		this.output.writeInt32(bytes.length);
		this.output.writeFullBytes(bytes, 0, bytes.length);
	}
	public function writeUtfBlob(value:String):Void {
		this.writeBlob(Bytes.ofString(value));
	}

	public function writeUtfString(value:Null<String>):Void {
		if (value == null) return this.output.writeInt32(-1);
		this.writeBlob(Bytes.ofString(value));
	}
}


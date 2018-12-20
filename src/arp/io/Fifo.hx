package arp.io;

import haxe.io.Eof;
import haxe.io.Bytes;
using arp.io.BytesTool;

class Fifo implements IBufferedInput implements IOutput implements IBlobInput implements IBlobOutput {

	private var _bigEndian:Bool;
	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return _bigEndian;
	private function set_bigEndian(value:Bool):Bool return _bigEndian = value;

	private var bytes:Bytes;

	private var readPosition:Int = 0;
	private var writePosition:Int = 0;
	public var bytesAvailable(get, never):Int;
	inline private function get_bytesAvailable():Int return writePosition - readPosition;

	private var mode:FifoMode = FifoMode.Write;

	inline private static var GC_MINIMUM:Int = 1024;

	public function new() {
		this.flush();
	}

	public function drain():Void return;

	private function writeMode(spaceDemand:Int = 16):Void {
		switch (this.mode) {
			case FifoMode.Read:
				this.mode = FifoMode.Write;
				this.ensure(spaceDemand);
			case _:
				if (this.writePosition + spaceDemand > this.bytes.length) this.ensure(spaceDemand);
		}
	}

	private function readMode(dataDemand:Int = 16):Void {
		switch (this.mode) {
			case FifoMode.Write:
				this.mode = FifoMode.Read;
				if (this.readPosition >= GC_MINIMUM) this.gc();
			case _:
		}
		if (this.bytesAvailable < dataDemand) throw new Eof();
	}

	private function gc():Void {
		var len:Int = this.bytesAvailable;
		var b:Bytes = Bytes.alloc(GC_MINIMUM + len);
		b.blit(0, this.bytes, this.readPosition, len);
		this.bytes = b;
		this.writePosition -= this.readPosition;
		this.readPosition = 0;
	}

	private function ensure(spaceDemand:Int):Void {
		if (this.writePosition + spaceDemand <= this.bytes.length) return;

		var len:Int = this.bytes.length;
		while (len < this.writePosition + spaceDemand) len += len;
		var b:Bytes = Bytes.alloc(len);
		if (this.readPosition > 0) {
			b.blit(0, this.bytes, this.readPosition, this.writePosition - this.readPosition);
			this.writePosition -= this.readPosition;
			this.readPosition = 0;
		} else {
			b.blit(0, this.bytes, 0, this.writePosition);
		}
		this.bytes = b;
	}

	public function flush():Void {
		this.readPosition = 0;
		this.writePosition = 0;
		this.bytes = Bytes.alloc(GC_MINIMUM);
	}

	//IDataOutput

	public function writeBool(value:Bool):Void {
		this.writeMode(1);
		this.bytes.set(this.writePosition, value ? 0xff : 0);
		this.writePosition += 1;
	}

	public function writeInt8(value:Int):Void {
		this.writeMode(1);
		this.bytes.set(this.writePosition, value & 0xff);
		this.writePosition += 1;
	}

	public function writeInt16(value:Int):Void {
		this.writeMode(2);
		if (bigEndian) this.bytes.setUInt16BE(this.writePosition, value & 0xffff)
		else this.bytes.setUInt16(this.writePosition, value & 0xffff);
		this.writePosition += 2;
	}

	public function writeInt32(value:Int):Void {
		this.writeMode(4);
		if (bigEndian) this.bytes.setInt32BE(this.writePosition, value)
		else this.bytes.setInt32(this.writePosition, value);
		this.writePosition += 4;
	}

	public function writeUInt8(value:UInt):Void {
		this.writeMode(1);
		this.bytes.set(this.writePosition, value);
		this.writePosition += 1;
	}

	public function writeUInt16(value:UInt):Void {
		this.writeMode(2);
		if (bigEndian) this.bytes.setUInt16BE(this.writePosition, value)
		else this.bytes.setUInt16(this.writePosition, value);
		this.writePosition += 2;
	}

	public function writeUInt32(value:UInt):Void {
		this.writeMode(4);
		if (bigEndian) this.bytes.setInt32BE(this.writePosition, value)
		else this.bytes.setInt32(this.writePosition, value);
		this.writePosition += 4;
	}

	public function writeFloat(value:Float):Void {
		this.writeMode(4);
		if (bigEndian) this.bytes.setFloatBE(this.writePosition, value)
		else this.bytes.setFloat(this.writePosition, value);
		this.writePosition += 4;
	}

	public function writeDouble(value:Float):Void {
		this.writeMode(8);
		if (bigEndian) this.bytes.setDoubleBE(this.writePosition, value)
		else this.bytes.setDouble(this.writePosition, value);
		this.writePosition += 8;
	}

	public function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void {
		this.writeMode(length);
		this.bytes.blit(this.writePosition, bytes, offset, length);
		this.writePosition += length;
	}

	public function writeUtfBytes(value:String):Void {
		var bytes:Bytes = Bytes.ofString(value);
		this.writeBytes(bytes, 0, bytes.length);
	}

	public function writeBlob(bytes:Bytes):Void {
		this.writeInt32(bytes.length);
		this.writeBytes(bytes, 0, bytes.length);
	}

	public function writeUtfBlob(value:String):Void {
		this.writeBlob(Bytes.ofString(value));
	}

	public function writeUtfString(value:String):Void {
		if (value == null) return this.writeInt32(-1);
		this.writeBlob(Bytes.ofString(value));
	}

	//IDataInput
	public function readBool():Bool {
		this.readMode(1);
		var v = this.bytes.get(this.readPosition);
		this.readPosition += 1;
		return v != 0;
	}

	public function readInt8():Int {
		this.readMode(1);
		var v = this.bytes.get(this.readPosition);
		this.readPosition += 1;
		return if (v >= 0x80) v - 0x100 else v;
	}

	public function readInt16():Int {
		this.readMode(2);
		var v = if (bigEndian) this.bytes.getUInt16BE(this.readPosition)
		else this.bytes.getUInt16(this.readPosition);
		this.readPosition += 2;
		return if (v >= 0x8000) v - 0x10000 else v;
	}

	public function readInt32():Int {
		this.readMode(4);
		var v = if (bigEndian) this.bytes.getInt32BE(this.readPosition)
		else this.bytes.getInt32(this.readPosition);
		this.readPosition += 4;
		return v;
	}

	public function readUInt8():UInt {
		this.readMode(1);
		var v = this.bytes.get(this.readPosition);
		this.readPosition += 1;
		return v;
	}

	public function readUInt16():UInt {
		this.readMode(2);
		var v = if (bigEndian) this.bytes.getUInt16BE(this.readPosition)
		else this.bytes.getUInt16(this.readPosition);
		this.readPosition += 2;
		return v & 0xffff;
	}

	public function readUInt32():UInt {
		this.readMode(4);
		var v = if (bigEndian) this.bytes.getInt32BE(this.readPosition)
		else this.bytes.getInt32(this.readPosition);
		this.readPosition += 4;
		return v;
	}

	public function readFloat():Float {
		this.readMode(4);
		var v = if (bigEndian) this.bytes.getFloatBE(this.readPosition)
		else this.bytes.getFloat(this.readPosition);
		this.readPosition += 4;
		return v;
	}

	public function readDouble():Float {
		this.readMode(8);
		var v = if (bigEndian) this.bytes.getDoubleBE(this.readPosition)
		else this.bytes.getDouble(this.readPosition);
		this.readPosition += 8;
		return v;
	}

	public function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void {
		this.readMode(length);
		bytes.blit(offset, this.bytes, this.readPosition, length);
		this.readPosition += length;
	}

	public function readUtfBytes(length:UInt):String {
		this.readMode(length);
		var bytes:Bytes = Bytes.alloc(length);
		bytes.blit(0, this.bytes, this.readPosition, length);
		this.readPosition += length;
		return bytes.toString();
	}

	public function readBlob():Bytes {
		var bytes:Bytes = this.peekBlob();
		if (bytes == null) throw "Invalid blob length";
		this.readPosition += bytes.length + 4;
		return bytes;
	}

	public function readUtfBlob():String {
		return this.readBlob().toString();
	}

	public function readUtfString():Null<String> {
		var bytes:Bytes = this.peekBlob();
		if (bytes == null) {
			this.readPosition += 4;
			return null;
		}
		this.readPosition += bytes.length + 4;
		return bytes.toString();
	}

	private function peekBlob():Bytes {
		this.readMode(4);
		var len:Int = if (this._bigEndian) this.bytes.getInt32BE(this.readPosition) else this.bytes.getInt32(this.readPosition);
		if (len < 0) return null;
		this.readMode(4 + len);
		var bytes:Bytes = Bytes.alloc(len);
		bytes.blit(0, this.bytes, this.readPosition + 4, len);
		return bytes;
	}

	public function nextBytes(limit:Int = 0):Bytes {
		var len = this.bytesAvailable;
		if (len > limit) len = limit;
		var result:Bytes = Bytes.alloc(len);
		this.readBytes(result, 0, len);
		return result;
	}

	public function nextBlob():Null<Bytes> {
		return try this.readBlob() catch (d:Dynamic) null;
	}

	public function nextUtfBlob():Null<String> {
		return try this.readUtfBlob() catch (d:Dynamic) null;
	}
}

private enum FifoMode {
	Write;
	Read;
}

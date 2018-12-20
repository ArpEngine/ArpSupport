package arp.io;

import haxe.io.Bytes;

class BufferedInput implements IBufferedInput {

	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return this.fifo.bigEndian;
	private function set_bigEndian(value:Bool):Bool {
		this.fifo.bigEndian = value;
		if (this.input != null) this.input.bigEndian = value;
		return value;
	}

	public var bytesAvailable(get, never):Int;
	private function get_bytesAvailable():Int {
		drain();
		return this.fifo.bytesAvailable;
	}

	private var _input:IInput;
	public var input(get, set):IInput;
	inline function get_input():IInput return _input;
	inline function set_input(value:IInput):IInput {
		if (value != null) value.bigEndian = this.bigEndian;
		this._input = value;
		return value;
	}

	private var fifo:Fifo;

	public function new(input:IInput = null) {
		this.fifo = new Fifo();
		this.input = input;
	}

	public function drain():Void {
		if (this.input == null) return;
		while (true) {
			var buf:Bytes = this.input.nextBytes(8192);
			if (buf.length == 0) break;
			this.fifo.writeBytes(buf, 0, buf.length);
		}
	}

	public function readBool():Bool {
		drain();
		return this.fifo.readBool();
	}

	public function readInt8():Int {
		drain();
		return this.fifo.readInt8();
	}
	public function readInt16():Int {
		drain();
		return this.fifo.readInt16();
	}
	public function readInt32():Int {
		drain();
		return this.fifo.readInt32();
	}

	public function readUInt8():UInt {
		drain();
		return this.fifo.readUInt8();
	}
	public function readUInt16():UInt {
		drain();
		return this.fifo.readUInt16();
	}
	public function readUInt32():UInt {
		drain();
		return this.fifo.readUInt32();
	}

	public function readFloat():Float {
		drain();
		return this.fifo.readFloat();
	}
	public function readDouble():Float {
		drain();
		return this.fifo.readDouble();
	}

	public function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void {
		drain();
		return this.fifo.readBytes(bytes, offset, length);
	}
	public function readUtfBytes(length:UInt):String {
		drain();
		return this.fifo.readUtfBytes(length);
	}

	public function readBlob():Bytes {
		drain();
		return this.fifo.readBlob();
	}
	public function readUtfBlob():String {
		drain();
		return this.fifo.readUtfBlob();
	}
	public function readUtfString():Null<String> {
		drain();
		return this.fifo.readUtfString();
	}

	public function nextBytes(limit:Int = 0):Bytes {
		drain();
		return this.fifo.nextBytes(limit);
	}
}


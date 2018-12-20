package arp.io;

import haxe.io.Bytes;

class BufferedOutput implements IBufferedOutput {

	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return this.fifo.bigEndian;
	private function set_bigEndian(value:Bool):Bool {
		this.fifo.bigEndian = value;
		if (this.output != null) this.output.bigEndian = value;
		return value;
	}

	private var _output:IOutput;
	public var output(get, set):IOutput;
	inline private function get_output():IOutput return _output;
	inline private function set_output(value:IOutput):IOutput {
		if (value != null) value.bigEndian = this.bigEndian;
		this._output = value;
		return value;
	}

	private var fifo:Fifo;

	public function new(output:IOutput = null) {
		this.fifo = new Fifo();
		this.output = output;
	}

	public function flush():Void {
		if (this.output == null) return;
		while (this.fifo.bytesAvailable > 0) {
			var buf:Bytes = this.fifo.nextBytes(8192);
			this.output.writeBytes(buf, 0, buf.length);
		}
	}

	public function writeBool(value:Bool):Void this.fifo.writeBool(value);

	public function writeInt8(value:Int):Void this.fifo.writeInt8(value);
	public function writeInt16(value:Int):Void this.fifo.writeInt16(value);
	public function writeInt32(value:Int):Void this.fifo.writeInt32(value);

	public function writeUInt8(value:UInt):Void this.fifo.writeUInt8(value);
	public function writeUInt16(value:UInt):Void this.fifo.writeUInt16(value);
	public function writeUInt32(value:UInt):Void this.fifo.writeUInt32(value);

	public function writeFloat(value:Float):Void this.fifo.writeFloat(value);
	public function writeDouble(value:Float):Void this.fifo.writeDouble(value);

	public function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void this.fifo.writeBytes(bytes, offset, length);
	public function writeUtfBytes(value:String):Void this.fifo.writeUtfBytes(value);

	public function writeBlob(value:Bytes):Void this.fifo.writeBlob(value);
	public function writeUtfBlob(value:String):Void this.fifo.writeUtfBlob(value);
	public function writeUtfString(value:Null<String>):Void this.fifo.writeUtfString(value);
}


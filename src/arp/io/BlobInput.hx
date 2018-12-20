package arp.io;

import haxe.io.Bytes;

class BlobInput implements IBlobInput {

	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return this.input.bigEndian;
	private function set_bigEndian(value:Bool):Bool {
		this.input.bigEndian = value;
		this.fifo.bigEndian = value;
		return value;
	}

	private var input:IInput;
	private var bytes:Bytes;
	private var fifo:Fifo;

	public function new(input:IInput) {
		this.input = input;
		this.fifo = new Fifo();
	}

	public function flush():Void fifo.flush();

	public function nextUtfBlob():Null<String> {
		var blob:Bytes = this.nextBlob();
		if (blob == null) return null;
		return blob.toString();
	}

	public function nextBlob():Null<Bytes> {
		var buf:Bytes;
		while (true) {
			buf = this.input.nextBytes(8192);
			if (buf.length == 0) break;
			this.fifo.writeBytes(buf, 0, buf.length);
		}

		if (this.bytes == null) {
			try {
				this.bytes = Bytes.alloc(this.fifo.readInt32());
			} catch (d:Dynamic) {
				return null;
			}
		}
		try {
			this.fifo.readBytes(this.bytes, 0, this.bytes.length);
			var result = this.bytes;
			this.bytes = null;
			return result;
		} catch (d:Dynamic) {
			return null;
		}
	}
}


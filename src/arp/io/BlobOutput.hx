package arp.io;

import haxe.io.Bytes;

class BlobOutput implements IBlobOutput {

	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return this.output.bigEndian;
	private function set_bigEndian(value:Bool):Bool return this.output.bigEndian = value;

	private var output:IOutput;

	public function new(output:IOutput) {
		this.output = output;
	}

	public function writeBlob(bytes:Bytes):Void {
		this.output.writeBlob(bytes);
	}

	public function writeUtfBlob(value:String):Void {
		this.output.writeUtfBlob(value);
	}
}


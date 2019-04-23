package arp.persistable;

import haxe.io.Bytes;
import arp.io.IOutput;

class PackedPersistOutput implements IPersistOutput {

	private var _output:IOutput;

	public var persistLevel(get, never):Int;
	private var _persistLevel:Int = 0;
	inline private function get_persistLevel():Int return this._persistLevel;

	public function new(output:IOutput, persistLevel:Int = 0) {
		this._output = output;
		this._persistLevel = persistLevel;
	}

	private var _uniqId:Int = 0;
	public function genName():String return '$${_uniqId++}';

	public function writeNameList(name:String, value:Array<String>):Void {
		this._output.writeUInt32(value.length);
		for (v in value) this._output.writeUtfBlob(v);
	}
	public function writePersistable(name:String, persistable:IPersistable):Void {
		this.writeEnter(name);
		persistable.writeSelf(this);
		this.writeExit();
	}

	public function writeEnter(name:String):Void return;
	public function writeExit():Void return;
	public function writeScope(name:String, body:IPersistOutput->Void):Void {
		this.writeEnter(name);
		body(this);
		this.writeExit();
	}

	public function writeBool(name:String, value:Bool):Void this._output.writeBool(value);
	public function writeInt32(name:String, value:Int):Void this._output.writeInt32(value);
	public function writeUInt32(name:String, value:Int):Void this._output.writeUInt32(value);
	public function writeDouble(name:String, value:Float):Void this._output.writeDouble(value);

	public function writeUtf(name:String, value:String):Void this._output.writeUtfBlob(value);
	public function writeBlob(name:String, bytes:Bytes):Void this._output.writeBlob(bytes);
}

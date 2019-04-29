package arp.persistable;

import arp.persistable.lambda.PersistOutputTools;
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

	public function writeEnter(name:String):Void return;
	public function writeListEnter(name:String):Void this.writeEnter(name);
	public function pushEnter():Void return;
	public function pushListEnter():Void this.pushEnter();
	public function writeExit():Void return;

	public function writeBool(name:String, value:Bool):Void this._output.writeBool(value);
	public function writeInt32(name:String, value:Int):Void this._output.writeInt32(value);
	public function writeUInt32(name:String, value:Int):Void this._output.writeUInt32(value);
	public function writeDouble(name:String, value:Float):Void this._output.writeDouble(value);

	public function writeUtf(name:String, value:String):Void this._output.writeUtfBlob(value);
	public function writeBlob(name:String, bytes:Bytes):Void this._output.writeBlob(bytes);

	public function pushBool(value:Bool):Void this.writeBool(null, value);
	public function pushInt32(value:Int):Void this.writeInt32(null, value);
	public function pushUInt32(value:UInt):Void this.writeUInt32(null, value);
	public function pushDouble(value:Float):Void this.writeDouble(null, value);

	public function pushUtf(value:String):Void this.writeUtf(null, value);
	public function pushBlob(value:Bytes):Void this.writeBlob(null, value);

	public function writePersistable(name:String, value:IPersistable):Void PersistOutputTools.writePersistableImpl(this, name, value);
	public function pushPersistable(value:IPersistable):Void PersistOutputTools.pushPersistableImpl(this, value);
	public function writeScope(name:String, body:IPersistOutput->Void):Void PersistOutputTools.writeScopeImpl(this, name, body);
	public function writeListScope(name:String, body:IPersistOutput->Void):Void PersistOutputTools.writeListScopeImpl(this, name, body);
}

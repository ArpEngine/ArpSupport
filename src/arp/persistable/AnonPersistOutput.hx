package arp.persistable;

import arp.persistable.impl.IObjectPersistOutput;
import haxe.io.Bytes;

class AnonPersistOutput implements IPersistOutput implements IObjectPersistOutput {

	private var _data:Dynamic;
	public var data(get, never):Dynamic;
	private function get_data():Dynamic return this._data;

	private var uniqId:Int = 0;
	private function nextName():String return '$$${uniqId++}';

	private var dataStack:Array<Dynamic>;
	private var idStack:Array<Int>;

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this._persistLevel;

	public function new(data:Dynamic = null, persistLevel:Int = 0) {
		this._data = (data != null) ? data : {};
		this.dataStack = [];
		this.idStack = [];
		this._persistLevel = persistLevel;
	}

	public function writeNameList(name:String, value:Array<String>):Void Reflect.setField(this._data, name, value);
	public function writePersistable(name:String, persistable:IPersistable):Void {
		this.writeEnter(name);
		persistable.writeSelf(this);
		this.writeExit();
	}

	public function writeEnter(name:String):Void {
		this.dataStack.push(this._data);
		this.idStack.push(this.uniqId);
		this.uniqId = 0;
		var data = {}
		Reflect.setField(this._data, name, data);
		this._data = data;
	}
	public function writeListEnter(name:String):Void this.writeEnter(name);
	public function writeExit():Void {
		this._data = this.dataStack.pop();
		this.uniqId = this.idStack.pop();
	}
	public function writeScope(name:String, body:IPersistOutput->Void):Void {
		this.writeEnter(name);
		body(this);
		this.writeExit();
	}
	public function writeListScope(name:String, body:IPersistOutput->Void):Void this.writeScope(name, body);

	public function writeBool(name:String, value:Bool):Void Reflect.setField(this._data, name, value);
	public function writeInt32(name:String, value:Int):Void Reflect.setField(this._data, name, value);
	public function writeUInt32(name:String, value:Int):Void Reflect.setField(this._data, name, value);
	public function writeDouble(name:String, value:Float):Void Reflect.setField(this._data, name, value);

	public function writeUtf(name:String, value:String):Void Reflect.setField(this._data, name, value);
	public function writeBlob(name:String, bytes:Bytes):Void Reflect.setField(this._data, name, bytes);
	public function writeAny(name:String, value:Dynamic):Void Reflect.setField(this._data, name, value);

	public function pushBool(value:Bool):Void this.writeBool(nextName(), value);
	public function pushInt32(value:Int):Void this.writeInt32(nextName(), value);
	public function pushUInt32(value:UInt):Void this.writeUInt32(nextName(), value);
	public function pushDouble(value:Float):Void this.writeDouble(nextName(), value);

	public function pushUtf(value:String):Void this.writeUtf(nextName(), value);
	public function pushBlob(value:Bytes):Void this.writeBlob(nextName(), value);
	public function pushAny(value:Dynamic):Void this.writeAny(nextName(), value);
}


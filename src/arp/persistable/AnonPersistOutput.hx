package arp.persistable;

import haxe.io.Bytes;

class AnonPersistOutput implements IPersistOutput {

	private var _data:Dynamic;
	public var data(get, never):Dynamic;
	private function get_data():Dynamic return this._data;

	private var dataStack:Array<Dynamic>;

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this._persistLevel;

	public function new(data:Dynamic = null, persistLevel:Int = 0) {
		this._data = (data != null) ? data : {};
		this.dataStack = [];
		this._persistLevel = persistLevel;
	}

	private var _uniqId:Int = 0;
	public function genName():String return '$$${_uniqId++}';

	public function writeNameList(name:String, value:Array<String>):Void Reflect.setField(this._data, name, value);
	public function writePersistable(name:String, persistable:IPersistable):Void {
		this.writeEnter(name);
		persistable.writeSelf(this);
		this.writeExit();
	}

	public function writeEnter(name:String):Void {
		this.dataStack.push(this._data);
		var data = {}
		Reflect.setField(this._data, name, data);
		this._data = data;
	}
	public function writeExit():Void this._data = this.dataStack.pop();
	public function writeScope(name:String, body:IPersistOutput->Void):Void {
		this.writeEnter(name);
		body(this);
		this.writeExit();
	}

	public function writeBool(name:String, value:Bool):Void Reflect.setField(this._data, name, value);
	public function writeInt32(name:String, value:Int):Void Reflect.setField(this._data, name, value);
	public function writeUInt32(name:String, value:Int):Void Reflect.setField(this._data, name, value);
	public function writeDouble(name:String, value:Float):Void Reflect.setField(this._data, name, value);

	public function writeUtf(name:String, value:String):Void Reflect.setField(this._data, name, value);
	public function writeBlob(name:String, bytes:Bytes):Void Reflect.setField(this._data, name, bytes);
}


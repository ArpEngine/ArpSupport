package arp.persistable;

import haxe.io.Bytes;

class AnonPersistInput implements IPersistInput {

	private var _data:Dynamic;
	private var dataStack:Array<Dynamic>;

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this._persistLevel;

	public function new(data:Dynamic, persistLevel:Int = 0) {
		this._data = data;
		this.dataStack = [];
		this._persistLevel = persistLevel;
	}

	public function readNameList(name:String):Array<String> return Reflect.field(this._data, name);
	public function readPersistable<T:IPersistable>(name:String, persistable:T):T {
		this.readEnter(name);
		persistable.readSelf(this);
		this.readExit();
		return persistable;
	}

	public function readEnter(name:String):Void {
		this.dataStack.push(this._data);
		this._data = Reflect.field(this._data, name);
	}
	public function readExit():Void this._data = this.dataStack.pop();
	public function readScope(name:String, body:IPersistInput->Void):Void {
		this.readEnter(name);
		body(this);
		this.readExit();
	}

	public function readBool(name:String):Bool return Reflect.field(this._data, name);
	public function readInt32(name:String):Int return Reflect.field(this._data, name);
	public function readUInt32(name:String):UInt return Reflect.field(this._data, name);
	public function readDouble(name:String):Float return Reflect.field(this._data, name);

	public function readUtf(name:String):String return Reflect.field(this._data, name);
	public function readBlob(name:String):Bytes return Reflect.field(this._data, name);
}


package arp.persistable;

import arp.persistable.impl.IObjectPersistInput;
import haxe.io.Bytes;

class AnonPersistInput implements IPersistInput implements IObjectPersistInput {

	private var _data:Dynamic;

	private var uniqId:Int = 0;
	private function nextName():String return '$$${uniqId++}';

	private var dataStack:Array<Dynamic>;
	private var idStack:Array<Int>;

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this._persistLevel;

	public function new(data:Dynamic, persistLevel:Int = 0) {
		this._data = data;
		this.dataStack = [];
		this.idStack = [];
		this._persistLevel = persistLevel;
	}

	public function pushState(data:Dynamic):Void {
		this.dataStack.push(this._data);
		this.idStack.push(this.uniqId);
		this._data = data;
		this.uniqId = 0;
	}

	public function popState():Bool {
		this._data = this.dataStack.pop();
		this.uniqId = this.idStack.pop();
		return this._data != null;
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
		this.idStack.push(this.uniqId);
		this.uniqId = 0;
		this._data = Reflect.field(this._data, name);
	}
	public function readListEnter(name:String):Void this.readEnter(name);
	public function readExit():Void {
		this._data = this.dataStack.pop();
		this.uniqId = this.idStack.pop();
	}
	public function readScope(name:String, body:IPersistInput->Void):Void {
		this.readEnter(name);
		body(this);
		this.readExit();
	}
	public function readListScope(name:String, body:IPersistInput->Void):Void this.readScope(name, body);

	public function readBool(name:String):Bool return Reflect.field(this._data, name);
	public function readInt32(name:String):Int return Reflect.field(this._data, name);
	public function readUInt32(name:String):UInt return Reflect.field(this._data, name);
	public function readDouble(name:String):Float return Reflect.field(this._data, name);

	public function readUtf(name:String):String return Reflect.field(this._data, name);
	public function readBlob(name:String):Bytes return Reflect.field(this._data, name);
	public function readAny(name:String):Dynamic return Reflect.field(this._data, name);

	public function nextBool():Bool return this.readBool(nextName());
	public function nextInt32():Int return this.readInt32(nextName());
	public function nextUInt32():UInt return this.readUInt32(nextName());
	public function nextDouble():Float return this.readDouble(nextName());

	public function nextUtf():String return this.readUtf(nextName());
	public function nextBlob():Bytes return this.readBlob(nextName());
	public function nextAny():Dynamic return this.readAny(nextName());
}


package arp.persistable;

import haxe.crypto.Base64;
import haxe.io.Bytes;
import haxe.Json;

@:access(arp.persistable.AnonPersistInput._data)

class JsonPersistInput implements IPersistInput {

	private var input:IPersistInput;
	private var anon:AnonPersistInput;

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this._persistLevel;

	public function new(json:String, persistLevel:Int = 0) {
		var data = Json.parse(json);
		this.anon = new AnonPersistInput(data, persistLevel);
		this.input = anon;
		this._persistLevel = persistLevel;
	}

	public function readBlob(name:String):Bytes {
		return Base64.decode(Reflect.field(this.anon._data, name));
	}
	public function nextBlob():Bytes return this.readBlob(@:privateAccess this.anon.nextName());

	public function readPersistable<T:IPersistable>(name:String, persistable:T):T {
		this.readEnter(name);
		persistable.readSelf(this);
		this.readExit();
		return persistable;
	}

	public function readEnter(name:String):Void this.input.readEnter(name);
	public function readListEnter(name:String):Void this.input.readListEnter(name);
	public function readExit():Void this.input.readExit();
	public function readScope(name:String, body:IPersistInput->Void):Void this.input.readScope(name, body);
	public function readListScope(name:String, body:IPersistInput->Void):Void this.input.readListScope(name, body);

	public function readNameList(name:String):Array<String> return this.input.readNameList(name);

	public function readBool(name:String):Bool return this.input.readBool(name);
	public function readInt32(name:String):Int return this.input.readInt32(name);
	public function readUInt32(name:String):UInt return this.input.readUInt32(name);
	public function readDouble(name:String):Float return this.input.readDouble(name);

	public function readUtf(name:String):String return this.input.readUtf(name);

	public function nextBool():Bool return this.input.nextBool();
	public function nextInt32():Int return this.input.nextInt32();
	public function nextUInt32():UInt return this.input.nextUInt32();
	public function nextDouble():Float return this.input.nextDouble();

	public function nextUtf():String return this.input.nextUtf();
}

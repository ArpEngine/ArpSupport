package arp.persistable;

import arp.persistable.impl.IObjectPersistInput;
import haxe.crypto.Base64;
import haxe.io.Bytes;
import haxe.Json;

class JsonPersistInput implements IPersistInput {

	private var input:IObjectPersistInput;
	private var anon:AnonPersistInput;
	private var array:ArrayPersistInput;

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this._persistLevel;

	public function new(json:String, persistLevel:Int = 0) {
		var data:Dynamic = Json.parse(json);
		this.anon = new AnonPersistInput(null, persistLevel);
		this.array = new ArrayPersistInput(null, persistLevel);
		if (Std.is(data, Array)) {
			this.input = this.array;
			this.array.pushState(data);
		} else {
			this.input = this.anon;
			this.anon.pushState(data);
		}
		this._persistLevel = persistLevel;
	}

	public function readBlob(name:String):Bytes return Base64.decode(this.input.readAny(name));
	public function nextBlob():Bytes return Base64.decode(this.input.nextAny());

	public function readPersistable<T:IPersistable>(name:String, persistable:T):T {
		this.readEnter(name);
		persistable.readSelf(this);
		this.readExit();
		return persistable;
	}

	public function readEnter(name:String):Void {
		var inner:Dynamic = this.input.readAny(name);
		if (this.input != this.anon) this.anon.pushState(null);
		this.input = this.anon;
		this.input.pushState(inner);
	}
	public function readListEnter(name:String):Void {
		var inner:Array<Dynamic> = this.input.readAny(name);
		if (this.input != this.array) this.array.pushState(null);
		this.input = this.array;
		this.input.pushState(inner);
	}
	public function readExit():Void {
		if (!this.input.popState()) {
			this.input.popState();
			this.input = if (this.input == this.array) this.anon else this.array;
		}
	}
	public function readScope(name:String, body:IPersistInput->Void):Void {
		this.readEnter(name);
		body(this);
		this.readExit();
	}
	public function readListScope(name:String, body:IPersistInput->Void):Void {
		this.readListEnter(name);
		body(this);
		this.readExit();
	}

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

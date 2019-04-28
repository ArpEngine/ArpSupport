package arp.persistable;

import arp.persistable.impl.IObjectPersistOutput;
import haxe.crypto.Base64;
import haxe.io.Bytes;
import haxe.Json;

class JsonPersistOutput implements IPersistOutput {

	private var output:IObjectPersistOutput;
	private var anon:AnonPersistOutput;
	private var array:ArrayPersistOutput;

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this._persistLevel;

	public var json(get, never):String;
	private function get_json():Dynamic return Json.stringify(this.anon.data);

	public function new(persistLevel:Int = 0) {
		this.anon = new AnonPersistOutput(null, persistLevel);
		this.array = new ArrayPersistOutput(null, persistLevel);
		if (false) {
			this.output = this.array;
			this.array.pushState([]);
		} else {
			this.output = this.anon;
			this.anon.pushState({});
		}
		this._persistLevel = persistLevel;
	}

	public function writeBlob(name:String, bytes:Bytes):Void this.output.writeAny(name, Base64.encode(bytes));
	public function pushBlob(bytes:Bytes):Void this.output.pushAny(Base64.encode(bytes));

	public function writePersistable(name:String, persistable:IPersistable):Void {
		this.writeEnter(name);
		persistable.writeSelf(this);
		this.writeExit();
	}

	public function writeEnter(name:String):Void {
		var inner:Dynamic = {};
		this.output.writeAny(name, inner);
		if (this.output != this.anon) this.anon.pushState(null);
		this.output = this.anon;
		this.output.pushState(inner);
	}
	public function writeListEnter(name:String):Void {
		var inner:Array<Dynamic> = [];
		this.output.writeAny(name, inner);
		if (this.output != this.array) this.array.pushState(null);
		this.output = this.array;
		this.output.pushState(inner);
	}
	public function writeExit():Void {
		if (!this.output.popState()) {
			this.output.popState();
			this.output = if (this.output == this.array) this.anon else this.array;
		}
	}
	public function writeScope(name:String, body:IPersistOutput->Void):Void {
		this.writeEnter(name);
		body(this);
		this.writeExit();
	}
	public function writeListScope(name:String, body:IPersistOutput->Void):Void {
		this.writeEnter(name);
		body(this);
		this.writeExit();
	}

	public function writeNameList(name:String, value:Array<String>):Void this.output.writeNameList(name, value);

	public function writeBool(name:String, value:Bool):Void this.output.writeBool(name, value);
	public function writeInt32(name:String, value:Int):Void this.output.writeInt32(name, value);
	public function writeUInt32(name:String, value:UInt):Void this.output.writeUInt32(name, value);
	public function writeDouble(name:String, value:Float):Void this.output.writeDouble(name, value);

	public function writeUtf(name:String, value:String):Void this.output.writeUtf(name, value);

	public function pushBool(value:Bool):Void this.output.pushBool(value);
	public function pushInt32(value:Int):Void this.output.pushInt32(value);
	public function pushUInt32(value:UInt):Void this.output.pushUInt32(value);
	public function pushDouble(value:Float):Void this.output.pushDouble(value);

	public function pushUtf(value:String):Void this.output.pushUtf(value);
}


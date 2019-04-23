package arp.persistable;

import haxe.io.Bytes;
import arp.io.IInput;

class PackedPersistInput implements IPersistInput {

	private var _input:IInput;

	public var persistLevel(get, never):Int;
	private var _persistLevel:Int = 0;
	inline private function get_persistLevel():Int return this._persistLevel;

	public function new(input:IInput, persistLevel:Int = 0) {
		this._input = input;
		this._persistLevel = persistLevel;
	}

	public function readNameList(name:String):Array<String> {
		var nameList:Array<String> = [];
		for (i in 0...this._input.readUInt32()) nameList.push(this._input.readUtfBlob());
		return nameList;
	}
	public function readPersistable<T:IPersistable>(name:String, persistable:T):T {
		this.readEnter(name);
		persistable.readSelf(this);
		this.readExit();
		return persistable;
	}

	public function readEnter(name:String):Void return;
	public function readExit():Void return;
	public function readScope(name:String, body:IPersistInput->Void):Void {
		this.readEnter(name);
		body(this);
		this.readExit();
	}

	public function readBool(name:String):Bool return this._input.readBool();
	public function readInt32(name:String):Int return this._input.readInt32();
	public function readUInt32(name:String):Int return this._input.readUInt32();
	public function readDouble(name:String):Float return this._input.readDouble();

	public function readUtf(name:String):String return this._input.readUtfBlob();
	public function readBlob(name:String):Bytes return this._input.readBlob();
}

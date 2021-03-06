package arp.persistable;

import arp.persistable.lambda.PersistInputTools;
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

	public function readEnter(name:String):Void return;
	public function readListEnter(name:String):Void this.readEnter(name);
	public function nextEnter():Void return;
	public function nextListEnter():Void this.nextEnter();
	public function readExit():Void return;

	public function readBool(name:String):Bool return this._input.readBool();
	public function readInt32(name:String):Int return this._input.readInt32();
	public function readUInt32(name:String):Int return this._input.readUInt32();
	public function readDouble(name:String):Float return this._input.readDouble();

	public function readUtf(name:String):String return this._input.readUtfBlob();
	public function readBlob(name:String):Bytes return this._input.readBlob();

	public function nextBool():Bool return this.readBool(null);
	public function nextInt32():Int return this.readInt32(null);
	public function nextUInt32():UInt return this.readUInt32(null);
	public function nextDouble():Float return this.readDouble(null);

	public function nextUtf():String return this.readUtf(null);
	public function nextBlob():Bytes return this.readBlob(null);

	public function readPersistable<T:IPersistable>(name:String, persistable:T):T return PersistInputTools.readPersistableImpl(this, name, persistable);
	public function nextPersistable<T:IPersistable>(value:T):T return PersistInputTools.nextPersistableImpl(this, value);
	public function readScope(name:String, body:IPersistInput->Void):Void PersistInputTools.readScopeImpl(this, name, body);
	public function readListScope(name:String, body:IPersistInput->Void):Void PersistInputTools.readListScopeImpl(this, name, body);
}

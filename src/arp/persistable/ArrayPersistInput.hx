package arp.persistable;

import arp.persistable.impl.IObjectPersistInput;
import arp.persistable.lambda.PersistInputTools;
import haxe.io.Bytes;

class ArrayPersistInput implements IPersistInput implements IObjectPersistInput {

	private var _data:Array<Dynamic>;
	private var index:Int = 0;

	private var dataStack:Array<Array<Dynamic>>;
	private var indexStack:Array<Int>;

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this._persistLevel;

	public function new(data:Array<Dynamic>, persistLevel:Int = 0) {
		this._data = data;
		this.dataStack = [];
		this.indexStack = [];
		this._persistLevel = persistLevel;
	}

	public function pushState(data:Dynamic):Void {
		this.dataStack.push(this._data);
		this.indexStack.push(this.index);
		this._data = data;
		this.index = 0;
	}

	public function popState():Bool {
		this._data = this.dataStack.pop();
		this.index = this.indexStack.pop();
		return this._data != null;
	}

	public function readNameList(name:String):Array<String> {
		return this._data[this.index++][1];
	}

	public function readEnter(name:String):Void this.pushState(this.readAny(name));
	public function readListEnter(name:String):Void this.readEnter(name);
	public function nextEnter():Void this.pushState(this.nextAny());
	public function nextListEnter():Void this.nextEnter();
	public function readExit():Void this.popState();

	public function readBool(name:String):Bool return this._data[this.index++][1];
	public function readInt32(name:String):Int return this._data[this.index++][1];
	public function readUInt32(name:String):UInt return this._data[this.index++][1];
	public function readDouble(name:String):Float return this._data[this.index++][1];

	public function readUtf(name:String):String return this._data[this.index++][1];
	public function readBlob(name:String):Bytes return this._data[this.index++][1];
	public function readAny(name:String):Dynamic return this._data[this.index++][1];

	public function nextBool():Bool return this._data[this.index++];
	public function nextInt32():Int return this._data[this.index++];
	public function nextUInt32():UInt return this._data[this.index++];
	public function nextDouble():Float return this._data[this.index++];

	public function nextUtf():String return this._data[this.index++];
	public function nextBlob():Bytes return this._data[this.index++];
	public function nextAny():Dynamic return this._data[this.index++];

	public function readPersistable<T:IPersistable>(name:String, persistable:T):T return PersistInputTools.readPersistableImpl(this, name, persistable);
	public function readScope(name:String, body:IPersistInput->Void):Void PersistInputTools.readScopeImpl(this, name, body);
	public function readListScope(name:String, body:IPersistInput->Void):Void PersistInputTools.readListScopeImpl(this, name, body);
}

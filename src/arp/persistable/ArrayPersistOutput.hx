package arp.persistable;

import arp.persistable.impl.IObjectPersistOutput;
import arp.persistable.lambda.PersistOutputTools;
import haxe.io.Bytes;

class ArrayPersistOutput implements IPersistOutput implements IObjectPersistOutput {

	private var _data:Array<Dynamic>;
	public var data(get, never):Array<Dynamic>;
	private function get_data():Array<Dynamic> return this._data;

	private var dataStack:Array<Array<Dynamic>>;

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this._persistLevel;

	public function new(data:Array<Dynamic> = null, persistLevel:Int = 0) {
		this._data = (data != null) ? data : [];
		this.dataStack = [];
		this._persistLevel = persistLevel;
	}

	public function pushState(data:Dynamic):Void {
		this.dataStack.push(this._data);
		this._data = data;
	}

	public function popState():Bool {
		this._data = this.dataStack.pop();
		return this._data != null;
	}

	public function writeNameList(name:String, value:Array<String>):Void this._data.push(([name, value]:Array<Dynamic>));

	public function writeEnter(name:String):Void {
		this.dataStack.push(this._data);
		var data = [];
		this._data.push(([name, data]:Array<Dynamic>));
		this._data = data;
	}
	public function writeListEnter(name:String):Void this.writeEnter(name);
	public function writeExit():Void {
		this._data = this.dataStack.pop();
	}

	public function writeBool(name:String, value:Bool):Void this._data.push(([name, value]:Array<Dynamic>));
	public function writeInt32(name:String, value:Int):Void this._data.push(([name, value]:Array<Dynamic>));
	public function writeUInt32(name:String, value:Int):Void this._data.push(([name, value]:Array<Dynamic>));
	public function writeDouble(name:String, value:Float):Void this._data.push(([name, value]:Array<Dynamic>));

	public function writeUtf(name:String, value:String):Void this._data.push(([name, value]:Array<Dynamic>));
	public function writeBlob(name:String, bytes:Bytes):Void this._data.push(([name, bytes]:Array<Dynamic>));
	public function writeAny(name:String, value:Dynamic):Void this._data.push(([name, value]:Array<Dynamic>));

	public function pushBool(value:Bool):Void this._data.push(value);
	public function pushInt32(value:Int):Void this._data.push(value);
	public function pushUInt32(value:UInt):Void this._data.push(value);
	public function pushDouble(value:Float):Void this._data.push(value);

	public function pushUtf(value:String):Void this._data.push(value);
	public function pushBlob(bytes:Bytes):Void this._data.push(bytes);
	public function pushAny(value:Dynamic):Void this._data.push(value);

	public function writePersistable(name:String, value:IPersistable):Void PersistOutputTools.writePersistableImpl(this, name, value);
	public function writeScope(name:String, body:IPersistOutput->Void):Void PersistOutputTools.writeScopeImpl(this, name, body);
	public function writeListScope(name:String, body:IPersistOutput->Void):Void PersistOutputTools.writeListScopeImpl(this, name, body);
}

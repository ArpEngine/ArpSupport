package arp.persistable;

import arp.persistable.lambda.PersistInputTools;
import haxe.io.Bytes;

class VerbosePersistInput implements IPersistInput {

	private var data:Array<String>;
	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this._persistLevel;

	public function new(data:Array<String>, persistLevel:Int = 0) {
		this.data = data;
		this._persistLevel = persistLevel;
	}

	private function next(value:Array<String>):String {
		var line:String = data.shift();
		var a:Array<String> = line.split(":");
		a.shift();
		a.shift();
		var payload:String = a.join(":");
		for (expected in value) {
			var command:String = a.shift();
			if (expected != command) throw 'unmatched command $line, expected ${value.join(":")}';
		}
		return a.join(":");
	}

	public function readEnter(name:String):Void this.next(["writeEnter", name]);
	public function readListEnter(name:String):Void this.next(["writeListEnter"]);
	public function nextEnter():Void this.next(["pushEnter"]);
	public function nextListEnter():Void this.next(["pushListEnter"]);
	public function readExit():Void this.next(["writeExit"]);

	public function readBool(name:String):Bool return this.next(["writeBool", name]) == "true";
	public function readInt32(name:String):Int return Std.parseInt(this.next(["writeInt32", name]));
	public function readUInt32(name:String):UInt return (Std.parseInt(this.next(["writeUInt32", name])):UInt);
	public function readDouble(name:String):Float return Std.parseFloat(this.next(["writeDouble", name]));

	public function readUtf(name:String):String return StringTools.urlDecode(this.next(["writeUtf", name]));
	public function readBlob(name:String):Bytes return Bytes.ofHex(this.next(["writeBlob", name]));

	public function nextBool():Bool return this.next(["pushBool"]) == "true";
	public function nextInt32():Int return Std.parseInt(this.next(["pushInt32"]));
	public function nextUInt32():UInt return (Std.parseInt(this.next(["pushUInt32"])):UInt);
	public function nextDouble():Float return Std.parseFloat(this.next(["pushDouble"]));

	public function nextUtf():String return StringTools.urlDecode(this.next(["pushUtf"]));
	public function nextBlob():Bytes return Bytes.ofHex(this.next(["pushBlob"]));

	public function readPersistable<T:IPersistable>(name:String, persistable:T):T return PersistInputTools.readPersistableImpl(this, name, persistable);
	public function nextPersistable<T:IPersistable>(value:T):T return PersistInputTools.nextPersistableImpl(this, value);
	public function readScope(name:String, body:IPersistInput->Void):Void PersistInputTools.readScopeImpl(this, name, body);
	public function readListScope(name:String, body:IPersistInput->Void):Void PersistInputTools.readListScopeImpl(this, name, body);
}

package arp.persistable.impl;

import arp.persistable.lambda.PersistOutputTools;
import haxe.io.Bytes;

class VerbosePersistOutputBase implements IPersistOutput {

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this._persistLevel;

	private var lineNum:Int = 0;
	private var indentLevel:Int = 0;

	private var header(get, never):String;
	private function get_header() {
		lineNum++;
		var line:String = StringTools.lpad('${lineNum}', " ", 4);
		var indent = StringTools.rpad('$indentLevel ', " ", indentLevel * 2 + 2);
		return '$line:$indent';
	}

	private function push(value:String):Void throw "implement me";

	public function new(persistLevel:Int = 0) {
		this._persistLevel = persistLevel;
	}

	public function writeEnter(name:String):Void {
		this.push('$header:writeEnter:$name');
		indentLevel++;
	}
	public function writeListEnter(name:String):Void {
		this.push('$header:writeListEnter:$name');
		indentLevel++;
	}
	public function pushEnter():Void {
		this.push('$header:pushEnter:');
		indentLevel++;
	}
	public function pushListEnter():Void {
		this.push('$header:pushListEnter:');
		indentLevel++;
	}
	public function writeExit():Void {
		indentLevel--;
		this.push('$header:writeExit:');
	}

	public function writeBool(name:String, value:Bool):Void this.push('$header:writeBool:$name:$value');
	public function writeInt32(name:String, value:Int):Void this.push('$header:writeInt32:$name:$value');
	public function writeUInt32(name:String, value:Int):Void this.push('$header:writeUInt32:$name:$value');
	public function writeDouble(name:String, value:Float):Void this.push('$header:writeDouble:$name:$value');

	public function writeUtf(name:String, value:String):Void this.push('$header:writeUtf:$name:${StringTools.urlEncode(value)}');
	public function writeBlob(name:String, bytes:Bytes):Void this.push('$header:writeBlob:$name:${bytes.toHex()}');

	public function pushBool(value:Bool):Void this.push('$header:pushBool:$value');
	public function pushInt32(value:Int):Void this.push('$header:pushInt32:$value');
	public function pushUInt32(value:UInt):Void this.push('$header:pushUInt32:$value');
	public function pushDouble(value:Float):Void this.push('$header:pushDouble:$value');

	public function pushUtf(value:String):Void this.push('$header:pushUtf:${StringTools.urlEncode(value)}');
	public function pushBlob(bytes:Bytes):Void this.push('$header:pushBlob:${bytes.toHex()}');

	public function writePersistable(name:String, value:IPersistable):Void PersistOutputTools.writePersistableImpl(this, name, value);
	public function pushPersistable(value:IPersistable):Void PersistOutputTools.pushPersistableImpl(this, value);
	public function writeScope(name:String, body:IPersistOutput->Void):Void PersistOutputTools.writeScopeImpl(this, name, body);
	public function writeListScope(name:String, body:IPersistOutput->Void):Void PersistOutputTools.writeListScopeImpl(this, name, body);
}

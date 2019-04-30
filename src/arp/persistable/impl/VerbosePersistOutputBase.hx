package arp.persistable.impl;

import arp.persistable.lambda.PersistOutputTools;
import haxe.io.Bytes;

class VerbosePersistOutputBase implements IPersistOutput {

	private var _persistLevel:Int = 0;
	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this._persistLevel;

	private var indentLevel:Int;
	public var indent(get, never):String;
	private function get_indent() {
		return StringTools.rpad('$indentLevel ', " ", indentLevel * 2 + 2);
	}

	private function push(value:String):Void throw "implement me";

	public function new(persistLevel:Int = 0) {
		this.indentLevel = 0;
		this._persistLevel = persistLevel;
	}

	public function writeEnter(name:String):Void {
		this.push('$indent:writeEnter:$name');
		indentLevel++;
	}
	public function writeListEnter(name:String):Void {
		this.push('$indent:writeListEnter:$name');
		indentLevel++;
	}
	public function pushEnter():Void {
		this.push('$indent:pushEnter:');
		indentLevel++;
	}
	public function pushListEnter():Void {
		this.push('$indent:pushListEnter:');
		indentLevel++;
	}
	public function writeExit():Void {
		indentLevel--;
		this.push('$indent:writeExit:');
	}

	public function writeBool(name:String, value:Bool):Void this.push('$indent:writeBool:$name:$value');
	public function writeInt32(name:String, value:Int):Void this.push('$indent:writeInt32:$name:$value');
	public function writeUInt32(name:String, value:Int):Void this.push('$indent:writeUInt32:$name:$value');
	public function writeDouble(name:String, value:Float):Void this.push('$indent:writeDouble:$name:$value');

	public function writeUtf(name:String, value:String):Void this.push('$indent:writeUtf:$name:${StringTools.urlEncode(value)}');
	public function writeBlob(name:String, bytes:Bytes):Void this.push('$indent:writeBlob:$name:${bytes.toHex()}');

	public function pushBool(value:Bool):Void this.push('$indent:pushBool:$value');
	public function pushInt32(value:Int):Void this.push('$indent:pushInt32:$value');
	public function pushUInt32(value:UInt):Void this.push('$indent:pushUInt32:$value');
	public function pushDouble(value:Float):Void this.push('$indent:pushDouble:$value');

	public function pushUtf(value:String):Void this.push('$indent:pushUtf:${StringTools.urlEncode(value)}');
	public function pushBlob(bytes:Bytes):Void this.push('$indent:pushBlob:${bytes.toHex()}');

	public function writePersistable(name:String, value:IPersistable):Void PersistOutputTools.writePersistableImpl(this, name, value);
	public function pushPersistable(value:IPersistable):Void PersistOutputTools.pushPersistableImpl(this, value);
	public function writeScope(name:String, body:IPersistOutput->Void):Void PersistOutputTools.writeScopeImpl(this, name, body);
	public function writeListScope(name:String, body:IPersistOutput->Void):Void PersistOutputTools.writeListScopeImpl(this, name, body);
}

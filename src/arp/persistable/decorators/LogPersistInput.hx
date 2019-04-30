package arp.persistable.decorators;

import arp.persistable.lambda.PersistInputTools;
import haxe.io.Bytes;

class LogPersistInput implements IPersistInput {

	private var indentLevel:Int;
	public var indent(get, never):String;
	private function get_indent() {
		return StringTools.rpad('$indentLevel ', " ", indentLevel * 2 + 2);
	}

	private var input:IPersistInput;

	public var persistLevel(get, never):Int;
	inline private function get_persistLevel():Int return this.input.persistLevel;

	public function new(input:IPersistInput) {
		this.input = input;
	}

	public function readEnter(name:String):Void {
		this.input.readEnter(name);
		trace('$indent:readEnter:$name');
		indentLevel++;
	}
	public function readListEnter(name:String):Void {
		this.input.readListEnter(name);
		trace('$indent:readListEnter:$name');
		indentLevel++;
	}
	public function nextEnter():Void {
		this.input.nextEnter();
		trace('$indent:nextEnter');
		indentLevel++;
	}
	public function nextListEnter():Void {
		this.input.nextListEnter();
		trace('$indent:nextListEnter');
		indentLevel++;
	}
	public function readExit():Void {
		this.input.readExit();
		indentLevel--;
		trace('$indent:readExit');
	}

	public function readBool(name:String):Bool {
		var value:Bool = this.input.readBool(name);
		trace('$indent:readBool:$value');
		return value;
	}
	public function readInt32(name:String):Int {
		var value:Int = this.input.readInt32(name);
		trace('$indent:readInt32:$value');
		return value;
	}
	public function readUInt32(name:String):UInt {
		var value:UInt = this.input.readUInt32(name);
		trace('$indent:readUInt32:$value');
		return value;
	}
	public function readDouble(name:String):Float {
		var value:Float = this.input.readDouble(name);
		trace('$indent:readDouble:$value');
		return value;
	}

	public function readUtf(name:String):String {
		var value:String = this.input.readUtf(name);
		trace('$indent:readUtf:${StringTools.urlEncode(value)}');
		return value;
	}
	public function readBlob(name:String):Bytes {
		var value:Bytes = this.input.readBlob(name);
		trace('$indent:readBlob:${value.toHex()}');
		return value;
	}

	public function nextBool():Bool {
		var value:Bool = this.input.nextBool();
		trace('$indent:nextBool:$value');
		return value;
	}
	public function nextInt32():Int {
		var value:Int = this.input.nextInt32();
		trace('$indent:nextInt32:$value');
		return value;
	}
	public function nextUInt32():UInt {
		var value:UInt = this.input.nextUInt32();
		trace('$indent:nextUInt32:$value');
		return value;
	}
	public function nextDouble():Float {
		var value:Float = this.input.nextDouble();
		trace('$indent:nextDouble:$value');
		return value;
	}

	public function nextUtf():String {
		var value:String = this.input.nextUtf();
		trace('$indent:nextUtf:${StringTools.urlEncode(value)}');
		return value;
	}
	public function nextBlob():Bytes {
		var value:Bytes = this.input.nextBlob();
		trace('$indent:nextBlob:${value.toHex()}');
		return value;
	}

	public function readPersistable<T:IPersistable>(name:String, persistable:T):T return PersistInputTools.readPersistableImpl(this, name, persistable);
	public function nextPersistable<T:IPersistable>(value:T):T return PersistInputTools.nextPersistableImpl(this, value);
	public function readScope(name:String, body:IPersistInput->Void):Void PersistInputTools.readScopeImpl(this, name, body);
	public function readListScope(name:String, body:IPersistInput->Void):Void PersistInputTools.readListScopeImpl(this, name, body);
}

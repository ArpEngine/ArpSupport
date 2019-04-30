package arp.persistable.decorators;

import arp.persistable.impl.TracePersistOutput;
import arp.persistable.lambda.PersistOutputTools;
import haxe.io.Bytes;

class LogPersistOutput implements IPersistOutput {

	private var outputs:Array<IPersistOutput>;
	private var output:IPersistOutput;

	public function new(output:IPersistOutput) {
		this.output = output;
		this.outputs = [new TracePersistOutput(output.persistLevel), output];
	}

	public var persistLevel(get, never):Int;
	public function get_persistLevel():Int return output.persistLevel;

	public function writeEnter(name:String):Void for (output in outputs) output.writeEnter(name);
	public function writeListEnter(name:String):Void for (output in outputs) output.writeListEnter(name);
	public function pushEnter():Void for (output in outputs) output.pushEnter();
	public function pushListEnter():Void for (output in outputs) output.pushListEnter();
	public function writeExit():Void for (output in outputs) output.writeExit();

	public function writeBool(name:String, value:Bool):Void for (output in outputs) output.writeBool(name, value);
	public function writeInt32(name:String, value:Int):Void for (output in outputs) output.writeInt32(name, value);
	public function writeUInt32(name:String, value:UInt):Void for (output in outputs) output.writeUInt32(name, value);
	public function writeDouble(name:String, value:Float):Void for (output in outputs) output.writeDouble(name, value);

	public function writeUtf(name:String, value:String):Void for (output in outputs) output.writeUtf(name, value);
	public function writeBlob(name:String, bytes:Bytes):Void for (output in outputs) output.writeBlob(name, bytes);

	public function pushBool(value:Bool):Void for (output in outputs) output.pushBool(value);
	public function pushInt32(value:Int):Void for (output in outputs) output.pushInt32(value);
	public function pushUInt32(value:UInt):Void for (output in outputs) output.pushUInt32(value);
	public function pushDouble(value:Float):Void for (output in outputs) output.pushDouble(value);

	public function pushUtf(value:String):Void for (output in outputs) output.pushUtf(value);
	public function pushBlob(bytes:Bytes):Void for (output in outputs) output.pushBlob(bytes);

	public function writePersistable(name:String, value:IPersistable):Void PersistOutputTools.writePersistableImpl(this, name, value);
	public function pushPersistable(value:IPersistable):Void PersistOutputTools.pushPersistableImpl(this, value);
	public function writeScope(name:String, body:IPersistOutput->Void):Void PersistOutputTools.writeScopeImpl(this, name, body);
	public function writeListScope(name:String, body:IPersistOutput->Void):Void PersistOutputTools.writeListScopeImpl(this, name, body);
}

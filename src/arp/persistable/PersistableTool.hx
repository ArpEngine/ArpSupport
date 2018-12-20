package arp.persistable;

import haxe.io.Bytes;

class PersistableTool {

	public static function readNullableNameList(me:IPersistInput, name:String):Null<Array<String>> {
		var input:IPersistInput = me.readEnter(name);
		var value = if (input.readBool("hasValue")) input.readNameList("value") else null;
		input.readExit();
		return value;
	}

	public static function readNullableBool(me:IPersistInput, name:String):Null<Bool> {
		var input:IPersistInput = me.readEnter(name);
		var value = if (input.readBool("hasValue")) input.readBool("value") else null;
		input.readExit();
		return value;
	}

	public static function readNullableInt32(me:IPersistInput, name:String):Null<Int> {
		var input:IPersistInput = me.readEnter(name);
		var value = if (input.readBool("hasValue")) input.readInt32("value") else null;
		input.readExit();
		return value;
	}

	public static function readNullableUInt32(me:IPersistInput, name:String):Null<UInt> {
		var input:IPersistInput = me.readEnter(name);
		var value = if (input.readBool("hasValue")) input.readUInt32("value") else null;
		input.readExit();
		return value;
	}

	public static function readNullableDouble(me:IPersistInput, name:String):Null<Float> {
		var input:IPersistInput = me.readEnter(name);
		var value = if (input.readBool("hasValue")) input.readDouble("value") else null;
		input.readExit();
		return value;
	}

	public static function readNullableUtf(me:IPersistInput, name:String):Null<String> {
		var input:IPersistInput = me.readEnter(name);
		var value = if (input.readBool("hasValue")) input.readUtf("value") else null;
		input.readExit();
		return value;
	}

	public static function readNullableBlob(me:IPersistInput, name:String):Null<Bytes> {
		var input:IPersistInput = me.readEnter(name);
		var value = if (input.readBool("hasValue")) input.readBlob("value") else null;
		input.readExit();
		return value;
	}

	public static function writeNullableNameList(me:IPersistOutput, name:String, value:Null<Array<String>>):Void {
		var output:IPersistOutput = me.writeEnter(name);
		output.writeBool("hasValue", value != null);
		if (value != null) output.writeNameList("value", value);
		output.writeExit();
	}

	public static function writeNullableBool(me:IPersistOutput, name:String, value:Null<Bool>):Void {
		var output:IPersistOutput = me.writeEnter(name);
		output.writeBool("hasValue", value != null);
		if (value != null) output.writeBool("value", value);
		output.writeExit();
	}

	public static function writeNullableInt32(me:IPersistOutput, name:String, value:Null<Int>):Void {
		var output:IPersistOutput = me.writeEnter(name);
		output.writeBool("hasValue", value != null);
		if (value != null) output.writeInt32("value", value);
		output.writeExit();
	}

	public static function writeNullableUInt32(me:IPersistOutput, name:String, value:Null<Int>):Void {
		var output:IPersistOutput = me.writeEnter(name);
		output.writeBool("hasValue", value != null);
		if (value != null) output.writeUInt32("value", value);
		output.writeExit();
	}

	public static function writeNullableDouble(me:IPersistOutput, name:String, value:Null<Float>):Void {
		var output:IPersistOutput = me.writeEnter(name);
		output.writeBool("hasValue", value != null);
		if (value != null) output.writeDouble("value", value);
		output.writeExit();
	}

	public static function writeNullableUtf(me:IPersistOutput, name:String, value:Null<String>):Void {
		var output:IPersistOutput = me.writeEnter(name);
		output.writeBool("hasValue", value != null);
		if (value != null) output.writeUtf("value", value);
		output.writeExit();
	}

	public static function writeNullableBlob(me:IPersistOutput, name:String, bytes:Null<Bytes>):Void {
		var output:IPersistOutput = me.writeEnter(name);
		output.writeBool("hasValue", bytes != null);
		if (bytes != null) output.writeBlob("value", bytes);
		output.writeExit();
	}
}

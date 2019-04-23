package arp.persistable;

import haxe.io.Bytes;

class PersistableTool {

	public static function readNullableNameList(me:IPersistInput, name:String):Null<Array<String>> {
		me.readEnter(name);
		var value = if (me.readBool("hasValue")) me.readNameList("value") else null;
		me.readExit();
		return value;
	}

	public static function readNullableBool(me:IPersistInput, name:String):Null<Bool> {
		me.readEnter(name);
		var value = if (me.readBool("hasValue")) me.readBool("value") else null;
		me.readExit();
		return value;
	}

	public static function readNullableInt32(me:IPersistInput, name:String):Null<Int> {
		me.readEnter(name);
		var value = if (me.readBool("hasValue")) me.readInt32("value") else null;
		me.readExit();
		return value;
	}

	public static function readNullableUInt32(me:IPersistInput, name:String):Null<UInt> {
		me.readEnter(name);
		var value = if (me.readBool("hasValue")) me.readUInt32("value") else null;
		me.readExit();
		return value;
	}

	public static function readNullableDouble(me:IPersistInput, name:String):Null<Float> {
		me.readEnter(name);
		var value = if (me.readBool("hasValue")) me.readDouble("value") else null;
		me.readExit();
		return value;
	}

	public static function readNullableUtf(me:IPersistInput, name:String):Null<String> {
		me.readEnter(name);
		var value = if (me.readBool("hasValue")) me.readUtf("value") else null;
		me.readExit();
		return value;
	}

	public static function readNullableBlob(me:IPersistInput, name:String):Null<Bytes> {
		me.readEnter(name);
		var value = if (me.readBool("hasValue")) me.readBlob("value") else null;
		me.readExit();
		return value;
	}

	public static function writeNullableNameList(me:IPersistOutput, name:String, value:Null<Array<String>>):Void {
		me.writeEnter(name);
		me.writeBool("hasValue", value != null);
		if (value != null) me.writeNameList("value", value);
		me.writeExit();
	}

	public static function writeNullableBool(me:IPersistOutput, name:String, value:Null<Bool>):Void {
		me.writeEnter(name);
		me.writeBool("hasValue", value != null);
		if (value != null) me.writeBool("value", value);
		me.writeExit();
	}

	public static function writeNullableInt32(me:IPersistOutput, name:String, value:Null<Int>):Void {
		me.writeEnter(name);
		me.writeBool("hasValue", value != null);
		if (value != null) me.writeInt32("value", value);
		me.writeExit();
	}

	public static function writeNullableUInt32(me:IPersistOutput, name:String, value:Null<Int>):Void {
		me.writeEnter(name);
		me.writeBool("hasValue", value != null);
		if (value != null) me.writeUInt32("value", value);
		me.writeExit();
	}

	public static function writeNullableDouble(me:IPersistOutput, name:String, value:Null<Float>):Void {
		me.writeEnter(name);
		me.writeBool("hasValue", value != null);
		if (value != null) me.writeDouble("value", value);
		me.writeExit();
	}

	public static function writeNullableUtf(me:IPersistOutput, name:String, value:Null<String>):Void {
		me.writeEnter(name);
		me.writeBool("hasValue", value != null);
		if (value != null) me.writeUtf("value", value);
		me.writeExit();
	}

	public static function writeNullableBlob(me:IPersistOutput, name:String, bytes:Null<Bytes>):Void {
		me.writeEnter(name);
		me.writeBool("hasValue", bytes != null);
		if (bytes != null) me.writeBlob("value", bytes);
		me.writeExit();
	}
}

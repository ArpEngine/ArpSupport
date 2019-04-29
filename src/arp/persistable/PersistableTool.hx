package arp.persistable;

import haxe.io.Bytes;

class PersistableTool {

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

	public static function nextNullableBool(me:IPersistInput):Null<Bool> {
		me.nextEnter();
		var value = if (me.readBool("hasValue")) me.readBool("value") else null;
		me.readExit();
		return value;
	}

	public static function nextNullableInt32(me:IPersistInput):Null<Int> {
		me.nextEnter();
		var value = if (me.readBool("hasValue")) me.readInt32("value") else null;
		me.readExit();
		return value;
	}

	public static function nextNullableUInt32(me:IPersistInput):Null<UInt> {
		me.nextEnter();
		var value = if (me.readBool("hasValue")) me.readUInt32("value") else null;
		me.readExit();
		return value;
	}

	public static function nextNullableDouble(me:IPersistInput):Null<Float> {
		me.nextEnter();
		var value = if (me.readBool("hasValue")) me.readDouble("value") else null;
		me.readExit();
		return value;
	}

	public static function nextNullableUtf(me:IPersistInput):Null<String> {
		me.nextEnter();
		var value = if (me.readBool("hasValue")) me.readUtf("value") else null;
		me.readExit();
		return value;
	}

	public static function nextNullableBlob(me:IPersistInput):Null<Bytes> {
		me.nextEnter();
		var value = if (me.readBool("hasValue")) me.readBlob("value") else null;
		me.readExit();
		return value;
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

	public static function pushNullableBool(me:IPersistOutput, value:Null<Bool>):Void {
		me.pushEnter();
		me.writeBool("hasValue", value != null);
		if (value != null) me.writeBool("value", value);
		me.writeExit();
	}

	public static function pushNullableInt32(me:IPersistOutput, value:Null<Int>):Void {
		me.pushEnter();
		me.writeBool("hasValue", value != null);
		if (value != null) me.writeInt32("value", value);
		me.writeExit();
	}

	public static function pushNullableUInt32(me:IPersistOutput, value:Null<Int>):Void {
		me.pushEnter();
		me.writeBool("hasValue", value != null);
		if (value != null) me.writeUInt32("value", value);
		me.writeExit();
	}

	public static function pushNullableDouble(me:IPersistOutput, value:Null<Float>):Void {
		me.pushEnter();
		me.writeBool("hasValue", value != null);
		if (value != null) me.writeDouble("value", value);
		me.writeExit();
	}

	public static function pushNullableUtf(me:IPersistOutput, value:Null<String>):Void {
		me.pushEnter();
		me.writeBool("hasValue", value != null);
		if (value != null) me.writeUtf("value", value);
		me.writeExit();
	}

	public static function pushNullableBlob(me:IPersistOutput, bytes:Null<Bytes>):Void {
		me.pushEnter();
		me.writeBool("hasValue", bytes != null);
		if (bytes != null) me.writeBlob("value", bytes);
		me.writeExit();
	}
}

package arp.io;

import haxe.Int64;
import haxe.io.Bytes;
using arp.io.BytesTool;

class BytesTool {

	private static var buffer:Bytes = Bytes.alloc(8);

	inline private static function readFlip(bytes:Bytes, pos:Int, len:Int):Void {
		var p:Int = pos + len;
		for (i in 0...len) buffer.set(i, bytes.get(--p));
	}

	inline private static function writeFlip(bytes:Bytes, pos:Int, len:Int):Void {
		var p:Int = pos + len;
		for (i in 0...len) bytes.set(--p, buffer.get(i));
	}

	public static function getDoubleBE(bytes:Bytes, pos:Int):Float {
		readFlip(bytes, pos, 8);
		return buffer.getDouble(0);
	}

	public static function getFloatBE(bytes:Bytes, pos:Int):Float {
		readFlip(bytes, pos, 4);
		return buffer.getFloat(0);
	}

	public static function setDoubleBE(bytes:Bytes, pos:Int, v:Float):Void {
		buffer.setDouble(0, v);
		writeFlip(bytes, pos, 8);
	}

	public static function setFloatBE(bytes:Bytes, pos:Int, v:Float):Void {
		buffer.setFloat(0, v);
		writeFlip(bytes, pos, 4);
	}

	inline public static function getUInt16BE(bytes:Bytes, pos:Int):Int {
		return bytes.get(pos + 1) | (bytes.get(pos) << 8);
	}

	inline public static function setUInt16BE(bytes:Bytes, pos:Int, v:Int):Void {
		bytes.set(pos + 1, v);
		bytes.set(pos, v >> 8);
	}

	inline public static function getInt32BE(bytes:Bytes, pos:Int):Int {
		var v = bytes.get(pos + 3) | (bytes.get(pos + 2) << 8) | (bytes.get(pos + 1) << 16) | (bytes.get(pos) << 24);
		return if( v & 0x80000000 != 0 ) v | 0x80000000 else v;
	}

	inline public static function getInt64BE(bytes:Bytes, pos:Int):Int64 {
		return haxe.Int64.make(getInt32BE(bytes, pos), getInt32BE(bytes, pos + 4));
	}

	inline public static function setInt32BE(bytes:Bytes, pos:Int, v:Int):Void {
		bytes.set(pos + 3, v);
		bytes.set(pos + 2, v >> 8);
		bytes.set(pos + 1, v >> 16);
		bytes.set(pos, v >>> 24);
	}

	inline public static function setInt64BE(bytes:Bytes, pos:Int, v:Int64):Void {
		setInt32BE(bytes, pos, v.high);
		setInt32BE(bytes, pos + 4, v.low);
	}

	inline public static function toBytes(bytesData:Array<Int>):Bytes {
		var length = bytesData.length;
		var bytes = Bytes.alloc(length);
		for (i in 0...length) bytes.set(i, bytesData[i]);
		return bytes;
	}

	inline public static function toArray(bytes:Bytes):Array<Int> {
		return [for (i in 0...bytes.length) bytes.get(i)];
	}
}


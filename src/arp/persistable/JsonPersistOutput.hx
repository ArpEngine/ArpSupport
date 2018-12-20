package arp.persistable;

import haxe.crypto.Base64;
import haxe.io.Bytes;
import haxe.Json;

class JsonPersistOutput extends AnonPersistOutput {

	public var json(get, never):String;
	private function get_json():Dynamic return Json.stringify(this.data);

	public function new(persistLevel:Int = 0) {
		super(null, persistLevel);
	}

	override public function writeEnter(name:String):IPersistOutput {
		var output:JsonPersistOutput = new JsonPersistOutput(this.persistLevel);
		Reflect.setField(this._data, name, output.data);
		return output;
	}

	override public function writeBlob(name:String, bytes:Bytes):Void {
		Reflect.setField(this._data, name, Base64.encode(bytes));
	}
}


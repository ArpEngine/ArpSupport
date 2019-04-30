package arp.testParams;

import arp.io.InputWrapper;
import arp.io.OutputWrapper;
import arp.persistable.AnonPersistInput;
import arp.persistable.AnonPersistOutput;
import arp.persistable.ArrayPersistInput;
import arp.persistable.ArrayPersistOutput;
import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;
import arp.persistable.JsonPersistInput;
import arp.persistable.JsonPersistOutput;
import arp.persistable.PackedPersistInput;
import arp.persistable.PackedPersistOutput;
import arp.persistable.VerbosePersistInput;
import arp.persistable.VerbosePersistOutput;
import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;

class PersistIoProviders {

	public static function persistIoProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new AnonPersistIoProvider()]);
		providers.push([new ArrayPersistIoProvider()]);
		providers.push([new JsonPersistIoProvider()]);
		providers.push([new PackedPersistIoProvider()]);
		providers.push([new VerbosePersistIoProvider()]);
		return providers;
	}

}

typedef IPersistIoProvider = {
	var output(get, never):IPersistOutput;
	var input(get, never):IPersistInput;
}

class AnonPersistIoProvider {
	public var data:Dynamic;
	private var _output:AnonPersistOutput;
	private var _input:AnonPersistInput;

	public function new() {
		this.data = { };
		this._output = new AnonPersistOutput(data);
		this._input = new AnonPersistInput(data);
	}

	public var output(get, never):IPersistOutput;
	public var input(get, never):IPersistInput;
	private function get_output():IPersistOutput return _output;
	private function get_input():IPersistInput return _input;
}

class ArrayPersistIoProvider {
	public var data:Array<Dynamic>;
	private var _output:ArrayPersistOutput;
	private var _input:ArrayPersistInput;

	public function new() {
		this.data = [];
		this._output = new ArrayPersistOutput(data);
		this._input = new ArrayPersistInput(data);
	}

	public var output(get, never):IPersistOutput;
	public var input(get, never):IPersistInput;
	private function get_output():IPersistOutput return _output;
	private function get_input():IPersistInput return _input;
}

class JsonPersistIoProvider {
	public var data:Dynamic;
	private var _output:JsonPersistOutput;
	private var _input:JsonPersistInput;

	public function new() {
		this._output = new JsonPersistOutput(data);
	}

	public var output(get, never):IPersistOutput;
	public var input(get, never):IPersistInput;
	private function get_output():IPersistOutput return _output;
	private function get_input():IPersistInput {
		if (this._input != null) return this._input;
		return this._input = new JsonPersistInput(this._output.json);
	}
}

class PackedPersistIoProvider {
	public var bytesOutput:BytesOutput;
	private var _output:PackedPersistOutput;
	private var _input:PackedPersistInput;

	public function new() {
		this.bytesOutput = new BytesOutput();
		this._output = new PackedPersistOutput(new OutputWrapper(this.bytesOutput));
	}
	public var output(get, never):IPersistOutput;
	public var input(get, never):IPersistInput;
	private function get_output():IPersistOutput return _output;
	private function get_input():IPersistInput {
		if (this._input != null) return this._input;
		return this._input = new PackedPersistInput(new InputWrapper(new BytesInput(this.bytes)));
	}

	public var bytes(get, never):Bytes;
	private function get_bytes():Bytes return this.bytesOutput.getBytes();
}

class VerbosePersistIoProvider {
	private var _output:VerbosePersistOutput;
	private var _input:VerbosePersistInput;

	public function new() {
		this._output = new VerbosePersistOutput();
	}
	public var output(get, never):IPersistOutput;
	public var input(get, never):IPersistInput;
	private function get_output():IPersistOutput return _output;
	private function get_input():IPersistInput {
		if (this._input != null) return this._input;
		return this._input = new VerbosePersistInput(this._output.data);
	}
}

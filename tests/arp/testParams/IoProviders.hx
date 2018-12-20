package arp.testParams;

import arp.io.BytesOutputWrapper;
import arp.io.BytesInputWrapper;
import arp.io.BufferedOutput;
import arp.io.IBufferedOutput;
import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;
import arp.io.Fifo;
import arp.io.IBufferedInput;
import arp.io.IInput;
import arp.io.IOutput;
import arp.io.InputWrapper;
import arp.io.BufferedInput;
import arp.io.OutputWrapper;

using arp.io.BytesTool;

#if flash
import flash.utils.ByteArray;
import arp.io.flash.DataOutputWrapper;
import arp.io.flash.DataInputWrapper;
#end

class IoProviders {
	public static function inputProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new InputWrapperProvider()]);
		providers.push([new BytesInputWrapperProvider()]);
		providers.push([new FifoInputProvider()]);
		providers.push([new BufferedInputWrapperProvider(new InputWrapperProvider())]);
		providers.push([new BufferedInputWrapperProvider(new FifoInputProvider())]);
		#if flash
		providers.push([new DataInputWrapperProvider()]);
		providers.push([new BufferedInputWrapperProvider(new DataInputWrapperProvider())]);
		#end
		return providers;
	}

	public static function outputProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new OutputWrapperProvider()]);
		providers.push([new BytesOutputWrapperProvider()]);
		providers.push([new FifoOutputProvider()]);
		providers.push([new BufferedOutputWrapperProvider(new OutputWrapperProvider())]);
		providers.push([new BufferedOutputWrapperProvider(new FifoOutputProvider())]);
		#if flash
		providers.push([new DataOutputWrapperProvider()]);
		providers.push([new BufferedOutputWrapperProvider(new DataOutputWrapperProvider())]);
		#end
		return providers;
	}
}

typedef IInputProvider = {
	function create(bytesData:Array<Int>):IInput;
}

typedef IOutputProvider = {
	function create():IOutput;
	function bytesData():Array<Int>;
}

class InputWrapperProvider {
	public function new() return;
	public function create(bytesData:Array<Int>):IInput {
		return new InputWrapper(new BytesInput(bytesData.toBytes()));
	}
}

class OutputWrapperProvider {
	private var bytesOutput:BytesOutput;
	public function new() return;
	public function create():IOutput {
		this.bytesOutput = new BytesOutput();
		return new OutputWrapper(this.bytesOutput);
	}
	public function bytesData():Array<Int> {
		return this.bytesOutput.getBytes().toArray();
	}
}

class BytesInputWrapperProvider {
	public function new() return;
	public function create(bytesData:Array<Int>):IInput {
		return new BytesInputWrapper(bytesData.toBytes());
	}
}

class BytesOutputWrapperProvider {
	private var output:BytesOutputWrapper;
	public function new() return;
	public function create():IOutput {
		return output = new BytesOutputWrapper();
	}
	public function bytesData():Array<Int> {
		return output.getBytes().toArray();
	}
}

class FifoInputProvider {
	public function new() return;
	public function create(bytesData:Array<Int>):IInput {
		var fifo = new Fifo();
		fifo.bigEndian = true;
		for (i in bytesData) fifo.writeUInt8(i);
		return fifo;
	}
}

class FifoOutputProvider {
	private var fifo:Fifo;
	public function new() return;
	public function create():IOutput {
		this.fifo = new Fifo();
		this.fifo.bigEndian = true;
		return this.fifo;
	}
	public function bytesData():Array<Int> {
		var bytes = Bytes.alloc(this.fifo.bytesAvailable);
		this.fifo.readBytes(bytes, 0, this.fifo.bytesAvailable);
		return bytes.toArray();
	}
}

class BufferedInputWrapperProvider {
	private var provider:IInputProvider;
	public function new(provider:IInputProvider) this.provider = provider;
	public function create(bytesData:Array<Int>):IBufferedInput {
		return new BufferedInput(provider.create(bytesData));
	}
}

class BufferedOutputWrapperProvider {
	private var provider:IOutputProvider;
	private var output:IBufferedOutput;
	public function new(provider:IOutputProvider) this.provider = provider;
	public function create():IBufferedOutput {
		return output = new BufferedOutput(provider.create());
	}
	public function bytesData():Array<Int> {
		output.flush();
		return provider.bytesData();
	}
}

#if flash

class DataInputWrapperProvider {
	public function new() return;
	public function create(bytesData:Array<Int>):IInput {
		var length = bytesData.length;
		var bytes = new ByteArray();
		for (i in 0...length) bytes.writeByte(bytesData[i]);
		bytes.position = 0;
		return new DataInputWrapper(bytes);
	}
}

class DataOutputWrapperProvider {
	private var bytes:ByteArray;
	public function new() return;
	public function create():IOutput {
		this.bytes = new ByteArray();
		return new DataOutputWrapper(this.bytes);
	}
	public function bytesData():Array<Int> {
		bytes.position = 0;
		return [for (i in 0...bytes.length) bytes.readUnsignedByte()];
	}
}
#end

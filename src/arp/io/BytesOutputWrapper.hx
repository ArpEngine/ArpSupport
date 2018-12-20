package arp.io;

import haxe.io.BytesOutput;
import haxe.io.Bytes;

import arp.io.OutputWrapper.OutputWrapperBase;

class BytesOutputWrapper extends OutputWrapperBase<BytesOutput> {

	public function getBytes():Bytes return this.output.getBytes();

	public function new() super(new BytesOutput());
}


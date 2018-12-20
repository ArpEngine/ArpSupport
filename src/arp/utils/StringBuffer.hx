package arp.utils;

import haxe.io.BytesBuffer;

abstract StringBuffer(BytesBuffer) {

	inline public function new(value:BytesBuffer) this = value;

	@:op(a+b)
	public function opAdd(value:String):StringBuffer {
		this.addString(value);
		return new StringBuffer(this);
	}

	@:op(a<<b)
	public function opPush(value:String):StringBuffer {
		this.addString(value);
		this.addString("\n");
		return new StringBuffer(this);
	}

	@:op(a*b)
	public function opSquiggle(value:String):StringBuffer {
		this.addString(ArpStringUtil.squiggle(value));
		return new StringBuffer(this);
	}

	@:op(a>>b)
	public function opPushSquiggle(value:String):StringBuffer {
		this.addString(ArpStringUtil.squiggle(value));
		this.addString("\n");
		return new StringBuffer(this);
	}

	@:from
	public static function fromString(string:String):StringBuffer {
		var bytesBuffer:BytesBuffer = new BytesBuffer();
		bytesBuffer.addString(string);
		return new StringBuffer(bytesBuffer);
	}

	@:from
	public static function fromInt(_:Int):StringBuffer {
		return new StringBuffer(new BytesBuffer());
	}

	@:to
	public function toString():String return this.getBytes().toString();
}

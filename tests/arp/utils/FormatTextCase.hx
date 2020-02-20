package arp.utils;

import picotest.PicoAssert.*;

class FormatTextCase {

	private var me:FormatText;

	public function testPublish() {
		me = new FormatText("{foo}{bar}");
		assertEquals("{foo}{bar}", me.publish(null));
	}

	public function testComplexPublish() {
		me = new FormatText("{foo}{bar}");
		var params:String->Any = name -> {
			return switch (name) {
				case "foo": "hoge";
				case "bar": "fuga";
				case _: "_";
			}
		};
		assertEquals("hogefuga", me.publish(params));
	}

	public function testFromAnon() {
		me = new FormatText("{foo}{bar}");
		var params = {
			foo: "hoge",
			bar: "fuga",
			baz: "piyo",
		};
		assertEquals("hogefuga", me.publish(params));
	}

	public function testFromArray() {
		me = new FormatText("{0}{2}");
		var params = ["hoge", "piyo", "fuga"];
		assertEquals("hogefuga", me.publish(params));
	}

	public function testCustomFormatterPublish() {
		var customFormatter:Any->String = _ -> "baz";
		me = new FormatText("{foo}", customFormatter);
		var params:String->Any = _ -> "bar";
		assertEquals("baz", me.publish(params));
	}
}

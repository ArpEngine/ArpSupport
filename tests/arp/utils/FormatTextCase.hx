package arp.utils;

import arp.utils.FormatText.FormatParams;
import picotest.PicoAssert.*;

class FormatTextCase {

	private var me:FormatText;

	public function testFormatOption() {
		assertEquals("", FormatOption.build("").flags);
		assertEquals("a", FormatOption.build("a").flags);
		assertEquals("a", FormatOption.build("a9").flags);
		assertEquals("b", FormatOption.build("9b").flags);
		assertEquals("ab", FormatOption.build("a9b").flags);
		assertEquals("ab8c", FormatOption.build("a9b8c").flags);
	}

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
		assertEquals("hogefuga", me.publish(FormatParams.fromAnon(params)));
	}

	public function testFromArray() {
		me = new FormatText("{0}{2}");
		var params = ["hoge", "piyo", "fuga"];
		assertEquals("hogefuga", me.publish(params));
	}

	public function testAlign() {
		me = new FormatText("{0:l},{1:c},{2:r}");
		var params:String->Any = _ -> "hoge";
		assertEquals("hoge,hoge,hoge", me.publish(params));
		me = new FormatText("{0:7l},{1:7c},{2:7r}");
		var params:String->Any = _ -> "fuga";
		assertEquals("fuga   , fuga  ,   fuga", me.publish(params));
	}

	public function testDefault() {
		me = new FormatText("{0::hoge}{0::fuga}");
		var params = _ -> null;
		assertEquals("hogefuga", me.publish(params));
	}

	public function testCustomFormatterPublish() {
		var customFormatter:Any->String = _ -> "baz";
		me = new FormatText("{foo}", customFormatter);
		var params:String->Any = _ -> "bar";
		assertEquals("baz", me.publish(params));
	}
}

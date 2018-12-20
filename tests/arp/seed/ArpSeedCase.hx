package arp.seed;

import arp.utils.ArpIdGenerator;
import picotest.PicoAssert.*;
import org.hamcrest.Matcher;
import org.hamcrest.Matchers;

class ArpSeedCase {

	private var autoKey(get, never):Matcher<Dynamic>;
	public function get_autoKey():Matcher<Dynamic> return Matchers.startsWith(ArpIdGenerator.AUTO_HEADER);

	private function toHash(seed:ArpSeed) return {
		typeName: Std.string(seed.seedName),
		className: seed.className,
		name: seed.name,
		key: seed.key,
		value: seed.value,
		kind: switch (seed.valueKind) {
			case ArpSeedValueKind.None: "n";
			case ArpSeedValueKind.Ambigious: "a";
			case ArpSeedValueKind.Literal: "l";
			case ArpSeedValueKind.Reference: "r";
		}
	};

	public function testEmptyXmlSeed():Void {
		var xml:Xml = Xml.parse('<root />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertTrue(seed.isSimple);
		assertMatch({typeName: "root", className: null, name: null, key: autoKey, value: null, kind: "l"}, toHash(seed));
		var iterator = seed.iterator();
		assertFalse(iterator.hasNext());
	}

	public function testSimpleXmlSeed():Void {
		var xml:Xml = Xml.parse('<data name="name6" class="className14" key="key28" value="value42" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertTrue(seed.isSimple);
		assertMatch({typeName: "data", className: "className14", name: "name6", key: "key28", value: "value42", kind: "l"}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "value", className: null, name: null, key: "key28", value: "value42", kind: "l"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithValue():Void {
		var xml:Xml = Xml.parse('<data>value128</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertTrue(seed.isSimple);
		assertMatch({typeName: "data", className: null, name: null, key: autoKey, value: "value128", kind: "l"}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "value", className: null, name: null, key: autoKey, value: "value128", kind: "l"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithAttrValue():Void {
		var xml:Xml = Xml.parse('<data name="name6" class="className14" valueKey="value42" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertFalse(seed.isSimple);
		assertMatch({typeName: "data", className: "className14", name: "name6", key: autoKey, value: null, kind: "n"}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "valueKey", className: null, name: null, key: autoKey, value: "value42", kind: "a"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithComplexValue():Void {
		var xml:Xml = Xml.parse('<data>value16<a />value32<b>valueb</b>value64</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertFalse(seed.isSimple);
		assertMatch({typeName: "data", className: null, name: null, key: autoKey, value: null, kind: "n"}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "a", className: null, name: null, key: autoKey, value: null, kind: "l"}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "b", className: null, name: null, key: autoKey, value: "valueb", kind: "l"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

}

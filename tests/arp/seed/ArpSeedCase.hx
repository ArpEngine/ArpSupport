package arp.seed;

import picotest.PicoAssert.*;
import org.hamcrest.Matcher;
import org.hamcrest.Matchers;

class ArpSeedCase {

	private var autoKey(get, never):Matcher<Dynamic>;
	public function get_autoKey():Matcher<Dynamic> return Matchers.nullValue();

	private function toHash(seed:ArpSeed) return {
		typeName: Std.string(seed.seedName),
		className: seed.className,
		name: seed.name,
		key: seed.key,
		value: seed.value,
		ref: seed.maybeRef
	};

	public function testEmptyXmlSeed():Void {
		var xml:Xml = Xml.parse('<root />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "root", className: null, name: null, key: autoKey, value: null, ref: false}, toHash(seed));
		var iterator = seed.iterator();
		assertFalse(iterator.hasNext());
	}

	public function testSimpleXmlSeed():Void {
		var xml:Xml = Xml.parse('<data name="name6" class="className14" key="key28" value="value42" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "data", className: "className14", name: "name6", key: "key28", value: "value42", ref: false}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "value", className: null, name: null, key: "key28", value: "value42", ref: false}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithValue():Void {
		var xml:Xml = Xml.parse('<data>value128</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "data", className: null, name: null, key: autoKey, value: "value128", ref: false}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "value", className: null, name: null, key: autoKey, value: "value128", ref: false}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithAttrValue():Void {
		var xml:Xml = Xml.parse('<data name="name6" class="className14" valueKey="value42" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "data", className: "className14", name: "name6", key: autoKey, value: null, ref: false}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "valueKey", className: null, name: null, key: autoKey, value: "value42", ref: true}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithComplexValue():Void {
		var xml:Xml = Xml.parse('<data>value16<a />value32<b>valueb</b>value64</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "data", className: null, name: null, key: autoKey, value: null, ref: false}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "a", className: null, name: null, key: autoKey, value: null, ref: false}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "b", className: null, name: null, key: autoKey, value: "valueb", ref: false}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testCopy():Void {
		var xml:Xml = Xml.parse('<data>value16<a />value32<b>valueb</b>value64</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);

		var withoutSource = seed.copy(false);
		assertNotEquals(withoutSource, seed);
		assertEquals(withoutSource.iterator().next(), seed.iterator().next());
		assertNull(withoutSource.source);
		assertMatch(toHash(withoutSource), toHash(seed));

		var withSource = seed.copy(true);
		assertNotEquals(withSource, seed);
		assertEquals(withSource.iterator().next(), seed.iterator().next());
		assertMatch(toHash(withSource), toHash(seed));
		assertNotNull(withSource.source);
	}

	public function testDeepCopy():Void {
		var xml:Xml = Xml.parse('<data>value16<a />value32<b>valueb</b>value64</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);

		var withoutSource = seed.deepCopy(false);
		assertNotEquals(withoutSource, seed);
		assertNotEquals(withoutSource.iterator().next(), seed.iterator().next());
		assertNull(withoutSource.source);
		assertMatch(toHash(withoutSource), toHash(seed));

		var withSource = seed.deepCopy(true);
		assertNotEquals(withSource, seed);
		assertNotEquals(withSource.iterator().next(), seed.iterator().next());
		assertMatch(toHash(withSource), toHash(seed));
		assertNotNull(withSource.source);
	}

	public function testCsvSimpleSeed():Void {
		var csv:String = "type,class,name,heat,value\nt1,c1,n1,h1,v1\n,,n2\n,,,\n";
		var seed:ArpSeed = ArpSeed.fromCsvString(csv, "lexical");
		assertMatch({typeName: "data", className: null, name: null, key: null, value: null, ref: false}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "t1", className: "c1", name: "n1", key: autoKey, value: "v1", ref: false}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "lexical", className: null, name: "n2", key: autoKey, value: null, ref: false}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testCsvSimpleSeed2():Void {
		var csv:String = "type,class,name,heat,value,field\nt1,c1,n1,h1,v1,f1\n,,n2\n,,n3,,,,,\n,,,\n";
		var seed:ArpSeed = ArpSeed.fromCsvString(csv, "lexical");
		assertMatch({typeName: "data", className: null, name: null, key: null, value: null, ref: false}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "t1", className: "c1", name: "n1", key: autoKey, value: "v1", ref: false}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "lexical", className: null, name: "n2", key: autoKey, value: null, ref: false}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "lexical", className: null, name: "n3", key: autoKey, value: null, ref: false}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testTsvSimpleSeed():Void {
		var tsv:String = "type\tclass\tname\theat\tvalue\nt1\tc1\tn1\th1\tv1\n\t\tn2\n\t\t\t\n";
		var seed:ArpSeed = ArpSeed.fromTsvString(tsv, "lexical");
		assertMatch({typeName: "data", className: null, name: null, key: null, value: null, ref: false}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "t1", className: "c1", name: "n1", key: autoKey, value: "v1", ref: false}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "lexical", className: null, name: "n2", key: autoKey, value: null, ref: false}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testTsvSimpleSeed2():Void {
		var tsv:String = "type\tclass\tname\theat\tvalue,field\nt1\tc1\tn1\th1\tv1\tf1\n\t\tn2\n\t\tn3\t\t\t\t\t\n\t\t\t\n";
		var seed:ArpSeed = ArpSeed.fromTsvString(tsv, "lexical");
		assertMatch({typeName: "data", className: null, name: null, key: null, value: null, ref: false}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "t1", className: "c1", name: "n1", key: autoKey, value: null, ref: false}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "lexical", className: null, name: "n2", key: autoKey, value: null, ref: false}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "lexical", className: null, name: "n3", key: autoKey, value: null, ref: false}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}
}

package arp.seed;

import arp.utils.ArpIdGenerator;

import picotest.PicoAssert.*;
import org.hamcrest.Matcher;
import org.hamcrest.Matchers;

class ArpSeedEnvCase {

	private var autoKey(get, never):Matcher<Dynamic>;
	public function get_autoKey():Matcher<Dynamic> return Matchers.startsWith(ArpIdGenerator.AUTO_HEADER);

	private function toHash(seed:ArpSeed) return {
		typeName: Std.string(seed.seedName),
		className: seed.className,
		name: seed.name,
		key: seed.key,
		value: seed.value,
		ref: seed.maybeRef
	};

	public function testDiverge():Void {
		var env1:ArpSeedEnv = ArpSeedEnv.empty();
		assertMatch(null, env1.get("key"));
		env1.add("key", "value");
		var env2:ArpSeedEnv = env1;
		assertMatch("value", env1.get("key"));
		assertMatch("value", env2.get("key"));
		env1.add("key1", "value1");
		env2.add("key2", "value2");
		assertMatch("value1", env1.get("key1"));
		assertMatch(null, env1.get("key2"));
		assertMatch(null, env2.get("key1"));
		assertMatch("value2", env2.get("key2"));
	}

	public function testOverride():Void {
		var env1:ArpSeedEnv = ArpSeedEnv.empty();
		env1.add("key", "value1");
		assertMatch("value1", env1.get("key"));
		var env2:ArpSeedEnv = env1;
		env2.add("key", "value2");
		assertMatch("value1", env1.get("key"));
		assertMatch("value2", env2.get("key"));
	}

	public function testDefaultClass():Void {
		var env1:ArpSeedEnv = ArpSeedEnv.empty();
		assertMatch(null, env1.getDefaultClass("key"));
		env1.add("default.key", "value");
		assertMatch("value", env1.getDefaultClass("key"));
	}

	public function testAddSeeds():Void {
		var env1:ArpSeedEnv = ArpSeedEnv.empty();
		var seed:ArpSeed = ArpSeed.createVerbatim("tt", "kk", "vv", env1);
		env1.addSeeds("seed.key", "value", [seed]);
		assertMatch([seed], env1.getDefaultSeeds("key"));
	}

	public function testEmptyXmlEnv():Void {
		var xml:Xml = Xml.parse('<root />').firstElement();
		var env:ArpSeedEnv = ArpSeed.fromXml(xml).env;
		assertTrue(env != null);
		assertTrue(env == ArpSeedEnv.empty());
	}

	public function testXmlEnvSeedsRootScope():Void {
		var xml:Xml = Xml.parse('<key dummy="root"><env name="seed.key" value="value" a="b"><c /></env></key>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		var env:ArpSeedEnv = seed.env;
		assertTrue(env != null);
		assertTrue(env == ArpSeedEnv.empty());
	}

	public function testXmlEnvSeedsIteratorRootScope():Void {
		var xml:Xml = Xml.parse('<key dummy="root"><env name="seed.key" value="value" a="b"><c /></env></key>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "key", className: null, name: null, key: autoKey, value: null, ref: false}, toHash(seed));
		var iterator = seed.iterator();

		assertTrue(iterator.hasNext());
		assertMatch({typeName: "dummy", className: null, name: null, key: autoKey, value: "root", ref: true}, toHash(iterator.next()));

		assertFalse(iterator.hasNext());
	}

	public function testXmlEnvSeedsChildScope():Void {
		var xml:Xml = Xml.parse('<root><key dummy="before" /><env name="seed.key" value="value" a="b"><c /></env><key dummy="after" /></root>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		var iterator = seed.iterator();

		assertTrue(iterator.hasNext());
		var before:ArpSeed = iterator.next();
		assertMatch("key", before.seedName);
		assertMatch(null, before.env.get("seed.key"));
		assertMatch(0, before.env.getDefaultSeeds("key").length);

		assertTrue(iterator.hasNext());
		var after:ArpSeed = iterator.next();
		assertMatch("key", after.seedName);
		assertMatch("value", after.env.get("seed.key"));
		assertMatch(2, after.env.getDefaultSeeds("key").length);

		assertFalse(iterator.hasNext());
	}

	public function testXmlEnvSeedsIteratorChildScope():Void {
		var xml:Xml = Xml.parse('<root><key dummy="before" /><env name="seed.key" value="value" a="b"><c /></env><key dummy="after" /></root>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "root", className: null, name: null, key: autoKey, value: null, ref: false}, toHash(seed));
		var iterator = seed.iterator();

		assertTrue(iterator.hasNext());
		var before:ArpSeed = iterator.next();
		assertMatch({typeName: "key", className: null, name: null, key: autoKey, value: null, ref: false}, toHash(before));
		var beforeIterator = before.iterator();
		assertTrue(beforeIterator.hasNext());
		assertMatch({typeName: "dummy", className: null, name: null, key: autoKey, value: "before", ref: true}, toHash(beforeIterator.next()));
		assertFalse(beforeIterator.hasNext());

		assertTrue(iterator.hasNext());
		var after:ArpSeed = iterator.next();
		assertMatch({typeName: "key", className: null, name: null, key: autoKey, value: null, ref: false}, toHash(after));
		var afterIterator = after.iterator();
		assertTrue(afterIterator.hasNext());
		assertMatch({typeName: "a", className: null, name: null, key: autoKey, value: "b", ref: true}, toHash(afterIterator.next()));
		assertTrue(afterIterator.hasNext());
		assertMatch({typeName: "c", className: null, name: null, key: autoKey, value: null, ref: false}, toHash(afterIterator.next()));
		assertTrue(afterIterator.hasNext());
		assertMatch({typeName: "dummy", className: null, name: null, key: autoKey, value: "after", ref: true}, toHash(afterIterator.next()));
		assertFalse(afterIterator.hasNext());

		assertFalse(iterator.hasNext());
	}
}

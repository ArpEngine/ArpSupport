package arp.seed;

import arp.utils.ArpIdGenerator;
import org.hamcrest.Matcher;
import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

class ArpSeedBuilderCase {

	private var autoKey(get, never):Matcher<Dynamic>;
	public function get_autoKey():Matcher<Dynamic> return Matchers.startsWith(ArpIdGenerator.AUTO_HEADER);

	private function createSeed():ArpSeed {
		var xml:Xml = Xml.parse('<data>value16<a />value32<b>valueb</b>value64</data>').firstElement();
		return ArpSeed.fromXml(xml);
	}

	private function toHash(seed:ArpSeed) return {
		typeName: Std.string(seed.seedName),
		className: seed.className,
		name: seed.name,
		key: seed.key,
		value: seed.value,
		ref: seed.maybeRef
	};

	public function testScratchSimple():Void {
		var builder:ArpSeedBuilder = ArpSeedBuilder.fromSeed(@:privateAccess new ArpSeed("dummySeed", "dummyKey", ArpSeedEnv.empty()));
		builder.seedName = "seed1";
		builder.key = "key2";
		builder.className = "className3";
		builder.name = "name4";
		builder.heat = "heat5";
		builder.maybeRef = false;
		builder.simpleValue = "simpleValue6";
		var seed:ArpSeed = builder.toSeed();
		assertMatch({typeName: "seed1", className: "className3", name: "name4", key: "key2", value: "simpleValue6", ref: false}, toHash(seed));
	}

	public function testSimpleSeedValue():Void {
		var builder:ArpSeedBuilder = ArpSeedBuilder.fromSeed(@:privateAccess new ArpSeed("dummySeed", "dummyKey", ArpSeedEnv.empty()));
		builder.value = "valuevalue";
		var seed:ArpSeed = builder.toSeed();
		assertMatch("valuevalue", seed.value);
	}

	public function testComplexSeedValue():Void {
		var builder:ArpSeedBuilder = ArpSeedBuilder.fromSeed(@:privateAccess new ArpSeed("dummySeed", "dummyKey", ArpSeedEnv.empty()));
		@:privateAccess builder.children = [];
		builder.value = "valuevalue";
		var seed:ArpSeed = builder.toSeed();
		assertMatch("valuevalue", seed.value);
	}

	public function testRoundTrip():Void {
		var source:ArpSeed = createSeed();
		var builder:ArpSeedBuilder = ArpSeedBuilder.fromSeed(source);
		var seed:ArpSeed = builder.toSeed();
		assertMatch(toHash(source), toHash(seed));
		assertNotEquals(source.iterator().next(), seed.iterator().next());
	}

	public function testShallowRoundTrip():Void {
		var source:ArpSeed = createSeed();
		var builder:ArpSeedBuilder = ArpSeedBuilder.fromSeedCopy(source.copy());
		var seed:ArpSeed = builder.toSeed();
		assertMatch(toHash(source), toHash(seed));
		assertEquals(source.iterator().next(), seed.iterator().next());
	}

	public function testAmend():Void {
		var source:ArpSeed = createSeed();
		var builder:ArpSeedBuilder = ArpSeedBuilder.fromSeedCopy(source.copy());
		for (cursor in builder.amend()) {
			var child:ArpSeed = cursor.value.deepCopy();
			cursor.remove();
			cursor.append(child);
		}
		var seed:ArpSeed = builder.toSeed();
		assertMatch(toHash(source), toHash(seed));
		assertNotEquals(source.iterator().next(), seed.iterator().next());
	}
}

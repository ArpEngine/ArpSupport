package arp.ds.persistable;

import arp.ds.impl.StdOmap;
import arp.testParams.PersistIoProviders.IPersistIoProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class PersistableIntOmapTest {

	private var provider:IPersistIoProvider;
	private var me:PersistableIntOmap;

	public function new() {
	}

	@Parameter
	public function setup(provider:IPersistIoProvider):Void {
		this.provider = provider;
		me = new PersistableIntOmap(new StdOmap<String, Int>());
	}

	public function testPersist():Void {
		me.addPair("name1", 1);
		me.addPair("name2", 2);
		me.addPair("name3", 3);
		me.writeSelf(provider.output);
		me = new PersistableIntOmap(new StdOmap<String, Int>());
		me.readSelf(provider.input);
		assertEquals(1, me.get("name1"));
		assertEquals(2, me.get("name2"));
		assertEquals(3, me.get("name3"));
		assertEquals(1, me.getAt(0));
		assertEquals(2, me.getAt(1));
		assertEquals(3, me.getAt(2));
	}

}

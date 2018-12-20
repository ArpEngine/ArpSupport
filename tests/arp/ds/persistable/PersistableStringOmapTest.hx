package arp.ds.persistable;

import arp.ds.impl.StdOmap;
import arp.testParams.PersistIoProviders.IPersistIoProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class PersistableStringOmapTest {

	private var provider:IPersistIoProvider;
	private var me:PersistableStringOmap;

	public function new() {
	}

	@Parameter
	public function setup(provider:IPersistIoProvider):Void {
		this.provider = provider;
		me = new PersistableStringOmap(new StdOmap<String, String>());
	}

	public function testPersist():Void {
		me.addPair("name1", "value1");
		me.addPair("name2", "value2");
		me.addPair("name3", "value3");
		me.writeSelf(provider.output);
		me = new PersistableStringOmap(new StdOmap<String, String>());
		me.readSelf(provider.input);
		assertEquals("value1", me.get("name1"));
		assertEquals("value2", me.get("name2"));
		assertEquals("value3", me.get("name3"));
		assertEquals("value1", me.getAt(0));
		assertEquals("value2", me.getAt(1));
		assertEquals("value3", me.getAt(2));
	}

}

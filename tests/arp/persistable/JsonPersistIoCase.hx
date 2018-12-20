package arp.persistable;

import arp.testParams.PersistIoProviders.JsonPersistIoProvider;
import arp.persistable.MockPersistable;

import picotest.PicoAssert.*;

class JsonPersistIoCase {

	private var provider:JsonPersistIoProvider;

	public function new() {
	}

	public function setup():Void {
		this.provider = new JsonPersistIoProvider();
	}

	// TODO unit test
	public function testPersistFormat():Void {
		var obj:MockPersistable = new MockPersistable(true);
		this.provider.output.writePersistable("obj", obj);
		assertNotNull(this.provider.data);
	}
}

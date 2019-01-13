package arp.events;

import arp.events.ArpSignal;
import picotest.PicoAssert.*;

using arp.events.ArpSignalTools;

class ArpSignalToolsCase {

	private var signal:ArpSignal<Int>;

	public function setup():Void {
		this.signal = new ArpSignal();
	}

	public function testPushSignal():Void {
		var v:Array<Int> = [];
		this.signal.push(_ -> v.push(1));
		var s = this.signal.pushSignal();
		s.push(_ -> v.push(2));
		this.signal.push(_ -> v.push(3));
		s.push(_ -> v.push(4));
		this.signal.dispatch(0);
		assertMatch([1, 2, 4, 3], v);
	}

	public function testAppendSignal():Void {
		var v:Array<Int> = [];
		this.signal.push(_ -> v.push(1));
		var s = this.signal.appendSignal();
		s.push(_ -> v.push(2));
		this.signal.push(_ -> v.push(3));
		s.push(_ -> v.push(4));
		this.signal.dispatch(0);
		assertMatch([1, 2, 4, 3], v);
	}

	public function testPrependSignal():Void {
		var v:Array<Int> = [];
		this.signal.push(_ -> v.push(1));
		var s = this.signal.prependSignal();
		s.push(_ -> v.push(2));
		this.signal.push(_ -> v.push(3));
		s.push(_ -> v.push(4));
		this.signal.dispatch(0);
		assertMatch([2, 4, 1, 3], v);
	}
}

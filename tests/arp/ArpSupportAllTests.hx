package arp;

import picotest.PicoTest;

class ArpSupportAllTests {
	static function main() {
		var r = PicoTest.runner();
		ArpSupportTestSuite.addTo(r);
		r.run();
	}
}

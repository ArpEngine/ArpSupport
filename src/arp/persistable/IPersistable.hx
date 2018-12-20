package arp.persistable;

import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;

interface IPersistable {
	function readSelf(input:IPersistInput):Void;
	function writeSelf(output:IPersistOutput):Void;
}



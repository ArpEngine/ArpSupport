package arp.ds.persistable;

import arp.ds.decorators.OmapDecorator;
import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;
import arp.persistable.IPersistable;

class PersistableIntOmap extends OmapDecorator<String, Int> implements IPersistable {

	public function new(omap:IOmap<String, Int>) {
		super(omap);
	}

	public function readSelf(input:IPersistInput):Void {
		PersistableIntOmapTool.readIntOmap(this, input);
	}

	public function writeSelf(output:IPersistOutput):Void {
		PersistableIntOmapTool.writeIntOmap(this, output);
	}

}

class PersistableIntOmapTool {

	inline public static function readIntOmap(omap:IOmap<String, Int>, input:IPersistInput):Void {
		omap.clear();
		var c:Int = input.readInt32("c");
		input.readListEnter("omap");
		for (i in 0...c) {
			input.nextEnter();
			var name:String = input.readUtf("name");
			omap.addPair(name, input.readInt32(name));
			input.readExit();
		}
		input.readExit();
	}

	inline public static function writeIntOmap(omap:IOmap<String, Int>, output:IPersistOutput):Void {
		var nameList:Array<String> = [for (name in omap.keys()) name];
		output.writeInt32("c", nameList.length);
		output.writeListEnter("omap");
		for (name in nameList) {
			output.pushEnter();
			output.writeUtf("name", name);
			output.writeInt32("value", omap.get(name));
			output.writeExit();
		}
		output.writeExit();
	}
}

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
		var nameList:Array<String> = input.readNameList("names");
		var values:IPersistInput = input.readEnter("values");
		for (name in nameList) {
			omap.addPair(name, values.readInt32(name));
		}
		values.readExit();
	}

	inline public static function writeIntOmap(omap:IOmap<String, Int>, output:IPersistOutput):Void {
		var nameList:Array<String> = [for (name in omap.keys()) name];
		output.writeNameList("names", nameList);
		var values:IPersistOutput = output.writeEnter("values");
		for (name in nameList) {
			output.writeInt32(name, omap.get(name));
		}
		values.writeExit();
	}
}

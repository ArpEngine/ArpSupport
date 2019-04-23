package arp.ds.persistable;

import arp.ds.decorators.OmapDecorator;
import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;
import arp.persistable.IPersistable;

class PersistableStringOmap extends OmapDecorator<String, String> implements IPersistable {

	public function new(omap:IOmap<String, String>) {
		super(omap);
	}

	public function readSelf(input:IPersistInput):Void {
		PersistableStringOmapTool.readStringOmap(this, input);
	}

	public function writeSelf(output:IPersistOutput):Void {
		PersistableStringOmapTool.writeStringOmap(this, output);
	}

}

class PersistableStringOmapTool {

	inline public static function readStringOmap(omap:IOmap<String, String>, input:IPersistInput):Void {
		omap.clear();
		var nameList:Array<String> = input.readNameList("names");
		input.readEnter("values");
		for (name in nameList) {
			omap.addPair(name, input.readUtf(name));
		}
		input.readExit();
	}

	inline public static function writeStringOmap(omap:IOmap<String, String>, output:IPersistOutput):Void {
		var nameList:Array<String> = [for (name in omap.keys()) name];
		output.writeNameList("names", nameList);
		output.writeEnter("values");
		for (name in nameList) {
			output.writeUtf(name, omap.get(name));
		}
		output.writeExit();
	}
}

package arp.ds.persistable;

import arp.ds.decorators.OmapDecorator;
import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;
import arp.persistable.IPersistable;

class PersistableOmap<V:IMappedPersistable> extends OmapDecorator<String, V> implements IPersistable {

	private var proto:V;

	public function new(omap:IOmap<String, V>, proto:V) {
		super(omap);
		this.proto = proto;
	}

	public function readSelf(input:IPersistInput):Void {
		PersistableOmapTool.readPersistableOmap(this, input, proto);
	}

	public function writeSelf(output:IPersistOutput):Void {
		PersistableOmapTool.writePersistableOmap(this, output);
	}

}

class PersistableOmapTool {

	inline public static function readPersistableOmap<V:IMappedPersistable>(omap:IOmap<String, V>, input:IPersistInput, proto:V):Void {
		omap.clear();
		var nameList:Array<String> = input.readNameList("names");
		input.readEnter("values");
		for (name in nameList) {
			var element:V = omap.get(name);
			if (element == null) {
				element = cast proto.clonePersistable(name);
				omap.addPair(name, element);
			}
			input.readPersistable(name, element);
		}
		input.readExit();
	}

	inline public static function writePersistableOmap<V:IMappedPersistable>(omap:IOmap<String, V>, output:IPersistOutput):Void {
		var nameList:Array<String> = [for (name in omap.keys()) name];
		output.writeNameList("names", nameList);
		output.writeEnter("values");
		for (name in nameList) {
			output.writePersistable(name, omap.get(name));
		}
		output.writeExit();
	}

}

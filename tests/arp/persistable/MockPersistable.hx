package arp.persistable;

import haxe.io.Bytes;

import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;
import arp.persistable.IPersistable;

class MockPersistable implements IPersistable {

	private var nameListField:Array<String>;
	private var boolField:Bool;
	private var intField:Int;
	private var doubleField:Float;
	private var utfField:String;
	private var blobField:Bytes;
	private var childField:MockPersistable;
	private var enterField:MockPersistable;

	public function new(hasChild:Bool = false) {
		this.nameListField = ["a", "b", "c"];
		this.boolField = hasChild;
		this.intField = hasChild ? 2 : 1;
		this.doubleField = 0.5;
		this.utfField = "utf";
		this.blobField = Bytes.alloc(hasChild ? 64 : 8);
		if (hasChild) {
			this.childField = new MockPersistable(false);
			this.enterField = new MockPersistable(false);
		}
	}

	public function readSelf(input:IPersistInput):Void {
		this.nameListField = input.readNameList("nameListValue");
		this.boolField = input.readBool("booleanValue");
		this.intField = input.readInt32("intValue");
		this.doubleField = input.readDouble("doubleValue");
		this.utfField = input.readUtf("utfValue");
		this.blobField = input.readBlob("blobValue");
		if (this.childField != null) {
			input.readPersistable("childValue", this.childField);
		}
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeNameList("nameListValue", this.nameListField);
		output.writeBool("booleanValue", this.boolField);
		output.writeInt32("intValue", this.intField);
		output.writeDouble("doubleValue", this.doubleField);
		output.writeUtf("utfValue", this.utfField);
		output.writeBlob("blobValue", this.blobField);
		if (this.childField != null) {
			output.writePersistable("childValue", this.childField);
		}
	}

	public function toString():String {
		return untyped [
			"[TestPersistable",
			this.nameListField,
			this.boolField,
			this.intField,
			this.doubleField,
			this.utfField,
			this.blobField.length,
			this.childField,
			this.enterField,
			"]"].join(" ");
	}
}

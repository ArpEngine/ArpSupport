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
	private var pushField0:Bool;
	private var pushField1:Int;
	private var pushField2:Float;
	private var pushField3:String;
	private var pushField4:Bytes;
	private var arrayField0:String;
	private var arrayField1:String;

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
		this.pushField0 = !hasChild;
		this.pushField1 = hasChild ? 100 : 200;
		this.pushField2 = hasChild ? 100.1 : 200.2;
		this.pushField3 = hasChild ? "111" : "222";
		this.pushField4 = Bytes.ofString(hasChild ? "64" : "8");
		this.arrayField0 = "a0";
		this.arrayField1 = "a1";
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
		this.pushField0 = input.nextBool();
		this.pushField1 = input.nextInt32();
		this.pushField2 = input.nextDouble();
		this.pushField3 = input.nextUtf();
		this.pushField4 = input.nextBlob();
		input.readListEnter("array");
		this.arrayField0 = input.nextUtf();
		this.arrayField1 = input.nextUtf();
		input.readExit();
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
		output.pushBool(this.pushField0);
		output.pushInt32(this.pushField1);
		output.pushDouble(this.pushField2);
		output.pushUtf(this.pushField3);
		output.pushBlob(this.pushField4);
		output.writeListEnter("array");
		output.pushUtf(this.arrayField0);
		output.pushUtf(this.arrayField1);
		output.writeExit();
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
			this.pushField0,
			this.pushField1,
			this.pushField2,
			this.pushField3,
			this.pushField4,
			this.arrayField0,
			this.arrayField1,
			"]"].join(" ");
	}
}

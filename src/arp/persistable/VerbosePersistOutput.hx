package arp.persistable;

import arp.persistable.impl.VerbosePersistOutputBase;

class VerbosePersistOutput extends VerbosePersistOutputBase implements IPersistOutput {

	public var data(default, null):Array<String>;
	public function toString():String return data.join("\n");

	override private function push(value:String):Void this.data.push(value);

	public function new(persistLevel:Int = 0) {
		super(persistLevel);
		this.data = [];
	}
}

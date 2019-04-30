package arp.persistable.impl;

import arp.persistable.impl.VerbosePersistOutputBase;

class TracePersistOutput extends VerbosePersistOutputBase implements IPersistOutput {

	override private function push(value:String):Void trace(value);

	public function new(persistLevel:Int = 0) {
		super(persistLevel);
	}
}

package arp.persistable.lambda;

class PersistOutputTools {

	inline public static function writePersistableImpl(me:IPersistOutput, name:String, value:IPersistable):Void {
		me.writeEnter(name);
		value.writeSelf(me);
		me.writeExit();
	}

	inline public static function pushPersistableImpl(me:IPersistOutput, value:IPersistable):Void {
		me.pushEnter();
		value.writeSelf(me);
		me.writeExit();
	}

	inline public static function writeScopeImpl(me:IPersistOutput, name:String, body:IPersistOutput->Void):Void {
		me.writeEnter(name);
		body(me);
		me.writeExit();
	}
	inline public static function writeListScopeImpl(me:IPersistOutput, name:String, body:IPersistOutput->Void):Void {
		me.writeListEnter(name);
		body(me);
		me.writeExit();
	}
}

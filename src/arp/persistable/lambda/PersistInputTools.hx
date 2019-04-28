package arp.persistable.lambda;

class PersistInputTools {

	inline public static function readPersistableImpl<T:IPersistable>(me:IPersistInput, name:String, persistable:T):T {
		me.readEnter(name);
		persistable.readSelf(me);
		me.readExit();
		return persistable;
	}

	inline public static function readScopeImpl(me:IPersistInput, name:String, body:IPersistInput->Void):Void {
		me.readEnter(name);
		body(me);
		me.readExit();
	}
	inline public static function readListScopeImpl(me:IPersistInput, name:String, body:IPersistInput->Void):Void {
		me.readListEnter(name);
		body(me);
		me.readExit();
	}
}

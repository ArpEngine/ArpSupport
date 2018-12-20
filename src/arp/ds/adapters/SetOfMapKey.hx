package arp.ds.adapters;

import arp.ds.access.ISetAmend.ISetAmendCursor;
import arp.ds.lambda.CollectionTools;
import arp.ds.ISet;
import arp.ds.IMap;

class SetOfMapKey<K, V> implements ISet<K> {

	private var map:IMap<K, V>;
	private var autoValue:K->V;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new(map:IMap<K, V>, autoValue:K->V) {
		this.map = map;
		this.autoValue = autoValue;
	}

	public function isEmpty():Bool return this.map.isEmpty();
	public function hasValue(v:K):Bool return this.map.hasKey(v);
	public function iterator():Iterator<K> return this.map.keys();
	public function toString():String return CollectionTools.setToStringImpl(this);

	public function add(v:K):Void if (!this.map.hasKey(v)) this.map.set(v, this.autoValue(v));

	public function remove(v:K):Bool return this.map.removeKey(v);
	public function clear():Void this.map.clear();

	//amend
	public function amend():Iterator<ISetAmendCursor<K>> return CollectionTools.setAmendImpl(this);
}

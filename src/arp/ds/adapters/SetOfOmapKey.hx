package arp.ds.adapters;

import arp.ds.access.ISetAmend.ISetAmendCursor;
import arp.ds.lambda.CollectionTools;
import arp.ds.ISet;
import arp.ds.IOmap;

class SetOfOmapKey<K, V> implements ISet<K> {

	private var omap:IOmap<K, V>;
	private var autoValue:K->V;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new(omap:IOmap<K, V>, autoValue:K->V) {
		this.omap = omap;
		this.autoValue = autoValue;
	}

	// read
	public function isEmpty():Bool return this.omap.isEmpty();
	public function hasValue(v:K):Bool return this.omap.hasKey(v);
	public function iterator():Iterator<K> return this.omap.keys();
	public function toString():String return CollectionTools.setToStringImpl(this);

	// write
	public function add(v:K):Void this.omap.addPair(v, this.autoValue(v));

	// remove
	public function remove(v:K):Bool return this.omap.removeKey(v);
	public function clear():Void this.omap.clear();

	//amend
	public function amend():Iterator<ISetAmendCursor<K>> return CollectionTools.setAmendImpl(this);
}

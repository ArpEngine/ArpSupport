package arp.ds.decorators;

import arp.ds.lambda.CollectionTools;
import arp.ds.access.ISetAmend.ISetAmendCursor;
import arp.ds.ISet;

class SetDecorator<V> implements ISet<V> {

	private var set:ISet<V>;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return this.set.isUniqueValue;

	public function new(set:ISet<V>) this.set = set;

	// read
	public function isEmpty():Bool return set.isEmpty();
	public function hasValue(v:V):Bool return set.hasValue(v);
	public function iterator():Iterator<V> return set.iterator();
	public function toString():String return set.toString();

	// write
	public function add(v:V):Void set.add(v);

	// remove
	public function remove(v:V):Bool return set.remove(v);
	public function clear():Void set.clear();

	//amend
	public function amend():Iterator<ISetAmendCursor<V>> return CollectionTools.setAmendImpl(this);
}

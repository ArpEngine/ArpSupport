package arp.ds.proxy;

import arp.ds.access.ISetAmend.ISetAmendCursor;
import arp.ds.lambda.CollectionTools;
import arp.ds.ISet;

class SetProxy<V, W> implements ISet<V> {

	private var set:ISet<W>;
	private var proxyValue:Null<Null<W>->Null<V>>;
	private var unproxyValue:Null<Null<V>->Null<W>>;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new(
		set:ISet<W>,
		?proxyValue:Null<W>->Null<V>,
		?unproxyValue:Null<V>->Null<W>
	) {
		this.set = set;
		this.proxyValue = proxyValue;
		this.unproxyValue = unproxyValue;
	}

	// read
	public function isEmpty():Bool return this.set.isEmpty();
	public function hasValue(v:V):Bool return this.set.hasValue(this.unproxyValue(v));
	public function iterator():Iterator<V> return new ProxyIterator(this.set.iterator(), this.proxyValue);
	public function toString():String return CollectionTools.setToStringImpl(this);

	// write
	public function add(v:V):Void return this.set.add(this.unproxyValue(v));

	// remove
	public function remove(v:V):Bool return this.set.remove(this.unproxyValue(v));
	public function clear():Void this.set.clear();

	// amend
	public function amend():Iterator<ISetAmendCursor<V>> return CollectionTools.setAmendImpl(this);
}

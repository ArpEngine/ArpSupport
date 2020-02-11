package arp.ds.decorators;

import arp.ds.access.ISetRead;
import arp.ds.ISet;

class CompositeSet<V> implements ISetRead<V> {

	private var sets:Array<ISet<V>>;

	public function new(set:ISet<V>, sets:Array<ISet<V>>) {
		super(set);
		this.sets = sets;
	}

	// read
	public function isEmpty():Bool return set.isEmpty();
	public function hasValue(v:V):Bool return set.hasValue(v);
	public function iterator():Iterator<V> return set.iterator();
	public function toString():String return set.toString();
}

package arp.ds;

import arp.ds.tree.TreePrinter;

@:final
class Tree<T> {

	public var children(get, never):Array<Tree<T>>;
	private var _children:Array<Tree<T>>;
	private function get_children():Array<Tree<T>> {
		return (this._children != null) ? this._children : (this._children = []);
	}

	public var hasChildren(get, never):Bool;
	private function get_hasChildren():Bool {
		return (this._children != null) && (this._children.length > 0);
	}

	public var value:T;

	public function new(value:T) {
		this.value = value;
	}

	public function toString():String {
		return new TreePrinter().format(this);
	}
}



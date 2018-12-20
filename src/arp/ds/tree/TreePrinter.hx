package arp.ds.tree;

import arp.ds.Tree;

class TreePrinter<V> implements ITreePrinter<V,String> {

	public function new() {
	}

	public function format(tree:Tree<V>, depth:Int = -1, level:Int = 0):String {
		var result:String = "";
		var indent:String = StringTools.lpad("", " ", level * 2);
		if (depth != 0 && tree.hasChildren) {
			for (item in tree.children) {
				result += indent + Std.string(tree.value) + "{\n";
				result += format(item, depth - 1, level + 1);
				result += indent + "}\n";
			}
		} else {
			result += indent + Std.string(tree.value) + "\n";
		}
		return result;
	}
}


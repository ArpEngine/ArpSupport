package arp.ds.tree;

interface ITreePrinter<V,Out> {
	function format(tree:Tree<V>, depth:Int = -1, level:Int = 0):Out;
}

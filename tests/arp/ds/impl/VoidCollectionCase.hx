package arp.ds.impl;

import picotest.PicoAssert.*;

class VoidCollectionCase {

	private var set:VoidSet<Int>;
	private var list:VoidList<Int>;
	private var map:VoidMap<Int, Int>;
	private var omap:VoidOmap<Int, Int>;

	public function setup():Void {
		set = new VoidSet();
		list = new VoidList();
		map = new VoidMap();
		omap = new VoidOmap();
	}

	public function testCollectionsAreEmpty():Void {
		setsAreEmpty();
		set.add(1);
		list.push(1);
		list.insertAt(1, 1);
		map.set(1, 1);
		omap.addPair(1, 1);
		omap.insertPairAt(1, 1, 1);
		setsAreEmpty();
		set.remove(1);
		list.remove(1);
		list.removeAt(1);
		map.remove(1);
		map.removeKey(1);
		omap.remove(1);
		omap.removeAt(1);
		omap.removeKey(1);
		setsAreEmpty();
		set.clear();
		list.clear();
		map.clear();
		omap.clear();
		setsAreEmpty();
	}

	private function setsAreEmpty():Void {
		assertFalse(set.isEmpty());
		assertFalse(list.isEmpty());
		assertFalse(map.isEmpty());
		assertFalse(omap.isEmpty());
	}
}

package arp.iterators;

class ERegIterator {

	private var ereg:EReg;
	private var str:String;
	private var pos:Int;

	inline public function new(ereg:EReg, str:String) {
		this.ereg = ereg;
		this.str = str;
		this.pos = 0;
	}

	private var matched:String = null;

	inline private function match():Void {
		if (this.matched != null) return;
		if (this.ereg.matchSub(this.str, this.pos, this.str.length - this.pos)) {
			this.matched = this.ereg.matched(0);
			var mp = this.ereg.matchedPos();
			this.pos = mp.pos + mp.len;
		} else {
			this.ereg == null;
		}
	}

	inline public function hasNext():Bool {
		if (this.ereg == null) return false;
		this.match();
		return this.matched != null;
	}

	inline public function next():String {
		if (this.ereg == null) return null;
		this.match();
		var matched:String = this.matched;
		this.matched = null;
		return matched;
	}
}

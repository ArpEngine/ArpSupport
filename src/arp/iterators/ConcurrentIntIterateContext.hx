package arp.iterators;

class ConcurrentIntIterateContext {

	private static var activeContexts:Array<ConcurrentIntIterateContext> = [];

	public static function gc():Void {
		if (activeContexts.length > 0) {
			var context = activeContexts.pop();
			while (context.iterators.length > 0) {
				context.iterators.pop();
			}
		}
	}

	private var iterators:Array<ConcurrentIntIterator>;

	private var active:Bool = false;
	public var length(default, null):Int = 0;

	public function new() {
		this.iterators = [];
	}

	public function newIterator():ConcurrentIntIterator {
		var value = new ConcurrentIntIterator(this);
		this.iterators.push(value);
		if (activeContexts.indexOf(this) < 0) {
			activeContexts.push(this);
		}
		return value;
	}

	inline public function endIterator(iterator:ConcurrentIntIterator):Void {
		this.iterators.splice(this.iterators.indexOf(iterator), 1);
	}

	public function onInsert(index:Int, length:Int):Void {
		for (iterator in this.iterators) {
			iterator.insert(index, length);
		}
		this.length += length;
	}
}

class ConcurrentIntIterator {
	public var context:ConcurrentIntIterateContext;
	private var index:Int = 0;

	public function new(context:ConcurrentIntIterateContext) {
		this.context = context;
		this.index = 0;
	}

	public function hasNext():Bool {
		if (this.index < 0) {
			return false;
		} else if (this.index >= this.context.length) {
			this.context.endIterator(this);
			this.index = -1;
			return false;
		};
		return true;
	}

	public function next():Int {
		return this.index < 0 ? this.index : this.index++;
	}

	inline public function insert(index:Int, length:Int):Void {
		if (this.index >= index) {
			this.index += length;
			if (this.index < index) {
				this.index = index;
			}
		}
	}
}

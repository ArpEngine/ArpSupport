package arp.events;

class ArpSignal<T> implements IArpSignalOut<T> implements IArpSignalIn<T> {

	private var handlers:Array<T->Void>;
	public function new() {
		this.handlers = [];
	}

	public function push(handler:T->Void):Int {
		return this.handlers.push(handler);
	}

	public function prepend(handler:T->Void):Int {
		this.handlers.unshift(handler);
		return this.handlers.length;
	}

	public function append(handler:T->Void):Int {
		return this.handlers.push(handler);
	}

	public function remove(handler:T->Void):Bool {
		return this.handlers.remove(handler);
	}

	public function flush():Void {
		this.handlers = [];
	}

	public function willTrigger():Bool {
		return this.handlers.length > 0;
	}

	public function dispatch(event:T):Void {
		for (handler in this.handlers) {
			handler(event);
		}
	}

	public function dispatchLazy(event:Void->T):Void {
		if (this.willTrigger()) this.dispatch(event());
	}
}

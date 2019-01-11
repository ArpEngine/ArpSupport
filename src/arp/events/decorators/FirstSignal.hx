package arp.events.decorators;

class FirstSignal<T> implements IArpSignalOut<T> {

	private var source:IArpSignalOut<T>;
	private var output:ArpSignal<T>;

	public function new(source:IArpSignalOut<T>) {
		this.output = new ArpSignal<T>();
		this.source = source;
		this.source.push(this.handler);
	}

	private function handler(event:T):Void {
		this.source.remove(this.handler);
		this.output.dispatch(event);
	}

	public function push(handler:T->Void):Int return this.output.push(handler);
	public function prepend(handler:T->Void):Int return this.output.prepend(handler);
	public function append(handler:T->Void):Int return this.output.append(handler);
	public function remove(handler:T->Void):Bool return this.output.remove(handler);
	public function flush():Void return this.output.flush();
}

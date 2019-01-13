package arp.events;

import arp.events.decorators.FirstSignal;

class ArpSignalTools {

	public static function first<T>(signal:IArpSignalOut<T>):IArpSignalOut<T> {
		return new FirstSignal(signal);
	}

	public static function pushSignal<T>(signal:IArpSignalOut<T>):IArpSignalOut<T> {
		var result:ArpSignal<T> = new ArpSignal<T>();
		signal.push(value -> result.dispatch(value));
		return result;
	}

	public static function prependSignal<T>(signal:IArpSignalOut<T>):IArpSignalOut<T> {
		var result:ArpSignal<T> = new ArpSignal<T>();
		signal.prepend(value -> result.dispatch(value));
		return result;
	}

	public static function appendSignal<T>(signal:IArpSignalOut<T>):IArpSignalOut<T> {
		var result:ArpSignal<T> = new ArpSignal<T>();
		signal.append(value -> result.dispatch(value));
		return result;
	}
}

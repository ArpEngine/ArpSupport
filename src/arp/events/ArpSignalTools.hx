package arp.events;

import arp.events.decorators.FirstSignal;

class ArpSignalTools {

	public static function first<T>(signal:IArpSignalOut<T>) {
		return new FirstSignal(signal);
	}
}

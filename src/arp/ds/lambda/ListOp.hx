package arp.ds.lambda;

class ListOp {

	public static function copy<V, T:IList<V>>(source:IList<V>, out:T):T {
		for (v in source) out.push(v);
		return out;
	}

	public static function and<V, T:IList<V>>(a:IList<V>, b:IList<V>, out:T):T {
		for (v in a) if (b.hasValue(v)) out.push(v);
		return out;
	}

	public static function or<V, T:IList<V>>(a:IList<V>, b:IList<V>, out:T):T {
		for (v in a) out.push(v);
		for (v in b) if (!a.hasValue(v)) out.push(v);
		return out;
	}

	public static function filter<V, T:IList<V>>(source:IList<V>, func:V->Bool, out:T):T {
		for (v in source) if (func(v)) out.push(v);
		return out;
	}

	public static function map<V, W, T:IList<W>>(source:IList<V>, func:V->W, out:T):T {
		for (v in source) out.push(func(v));
		return out;
	}

	public static function bulkPush<V, T:IList<V>>(target:T, source:IList<V>):T {
		for (v in source) target.push(v);
		return target;
	}

	public static function bulkPushArray<V, T:IList<V>>(target:T, source:Array<V>):T {
		for (v in source) target.push(v);
		return target;
	}

	public static function toArray<V>(source:IList<V>):Array<V> {
		return [for (v in source) v];
	}

	public static function toAnon<V>(source:IList<V>):Dynamic {
		var anon:Dynamic = {};
		for (v in source) Reflect.setField(anon, Std.string(v), v);
		return anon;
	}
}

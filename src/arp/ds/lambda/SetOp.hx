package arp.ds.lambda;

class SetOp {

	public static function copy<V, T:ISet<V>>(source:ISet<V>, out:T):T {
		for (v in source) out.add(v);
		return out;
	}

	public static function and<V, T:ISet<V>>(a:ISet<V>, b:ISet<V>, out:T):T {
		for (v in a) if (b.hasValue(v)) out.add(v);
		return out;
	}

	public static function or<V, T:ISet<V>>(a:ISet<V>, b:ISet<V>, out:T):T {
		for (v in a) out.add(v);
		for (v in b) out.add(v);
		return out;
	}

	public static function filter<V, T:ISet<V>>(source:ISet<V>, func:V->Bool, out:T):T {
		for (v in source) if (func(v)) out.add(v);
		return out;
	}

	public static function map<V, W, T:ISet<W>>(source:ISet<V>, func:V->W, out:T):T {
		for (v in source) out.add(func(v));
		return out;
	}

	public static function bulkAdd<V, T:ISet<V>>(target:T, source:ISet<V>):T {
		for (v in source) target.add(v);
		return target;
	}

	public static function bulkAddArray<V, T:ISet<V>>(target:T, values:Array<V>):T {
		for (v in values) target.add(v);
		return target;
	}

	public static function toArray<V>(source:ISet<V>):Array<V> {
		return [for (v in source) v];
	}

	public static function toAnon<V>(source:ISet<V>):Dynamic {
		var anon:Dynamic = {};
		for (v in source) Reflect.setField(anon, Std.string(v), v);
		return anon;
	}

}

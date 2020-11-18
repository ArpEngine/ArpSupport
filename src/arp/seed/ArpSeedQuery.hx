package arp.seed;

class ArpSeedQuery {

	private var seed:ArpSeed;

	private var directChildren(get, never):Null<Array<ArpSeed>>;
	inline private function get_directChildren():Null<Array<ArpSeed>> return @:privateAccess this.seed.children;

	private var safeDirectChildren(get, never):Array<ArpSeed>;
	inline private function get_safeDirectChildren():Array<ArpSeed> return if (this.directChildren == null) [] else this.directChildren;

	public function new(seed:ArpSeed) this.seed = seed;

	public function findByName(seedName:String):Null<ArpSeed> {
		return Lambda.find(this.seed, (child:ArpSeed) -> child.seedName == seedName);
	}

	public function findDirectByName(seedName:String):Null<ArpSeed> {
		return Lambda.find(this.safeDirectChildren, (child:ArpSeed) -> child.seedName == seedName);
	}
}

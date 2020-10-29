package arp.seed.builder;

import arp.seed.sources.ArpSeedXmlSource;
import arp.seed.sources.IArpSeedSource;

abstract ArpSeedWithoutSource(ArpSeed) from ArpSeed {

	public function new(seed:ArpSeed) this = seed;

	public function withoutSource():ArpSeed return this;

	public function withSource(source:IArpSeedSource):ArpSeed {
		@:privateAccess this.source = source;
		return this;
	}

	inline public function withXmlSource(xml:Xml, attr:Null<String> = null):ArpSeed return withSource(new ArpSeedXmlSource(xml, attr));
}

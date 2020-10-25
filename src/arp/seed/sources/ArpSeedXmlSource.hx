package arp.seed.sources;

class ArpSeedXmlSource implements IArpSeedSource {

	public var xml:Xml;
	public var attr:Null<String>;

	public function new(xml:Xml, attr:Null<String> = null) {
		this.xml = xml;
		this.attr = attr;
	}
}

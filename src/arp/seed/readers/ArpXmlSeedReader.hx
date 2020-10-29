package arp.seed.readers;

import arp.utils.ArpIdGenerator;
import haxe.io.Bytes;
import Xml.XmlType;

class ArpXmlSeedReader {

	/*
		ArpXmlSeedReader spec:
		- Attributes:
		  - All keyword attributes are ignored
		  - All non-keyword attributes are Ambigious ArpSimpleSeed
		- Elements:
		  - When an element has a "ref" attribute, it is an Reference ArpSimpleSeed
		  - Else, an element is am ArpComplexSeed
		    - Text nodes inside will become Literal ArpSimpleSeed
	 */

	inline public function new() {
	}

	inline public function parseXmlBytes(bytes:Bytes, env:ArpSeedEnv = null):ArpSeed {
		return parseXmlString(bytes.toString(), env);
	}

	inline public function parseXmlString(xmlString:String, env:ArpSeedEnv = null):ArpSeed {
		return parse(Xml.parse(xmlString), env);
	}

	inline public function parse(xml:Xml, env:ArpSeedEnv = null):ArpSeed {
		if (env == null) env = ArpSeedEnv.empty();
		return parseInternal(xml, ArpIdGenerator.first, env);
	}

	private function parseInternal(xml:Xml, uniqId:String, env:ArpSeedEnv):ArpSeed {
		switch (xml.nodeType) {
			case XmlType.Document: xml = xml.firstElement();
			case XmlType.Element:
			case _: return ArpSeed.createSimple(xml.nodeName, uniqId, xml.nodeValue, env).withXmlSource(xml);
		}

		var idGen:ArpIdGenerator = new ArpIdGenerator();

		var typeName:String = xml.nodeName;
		var className:String = null;
		var name:String = null;
		var heat:String = null;
		var key:String = uniqId;
		var value:String = null;
		var isRef:Bool = false;
		var textNodeValue:String = null;
		var acceptsTextNodeValue:Bool = true;
		var children:Array<ArpSeed> = null;
		var innerEnv:ArpSeedEnv = env;

		for (attrName in xml.attributes()) {
			var attr:String = xml.get(attrName);
			switch (attrName) {
				case "type":
					typeName = attr;
				case "class":
					className = attr;
				case "name", "id":
					name = attr;
				case "ref":
					value = attr;
					isRef = true;
				case "heat":
					heat = attr;
				case "key":
					key = attr;
				case "value":
					value = attr;
					acceptsTextNodeValue = false;
				case _:
					// NOTE leaf seeds by xml attr are also treated as ref; text nodes are not
					if (children == null) children = [];
					children.push(ArpSeed.createSimple(attrName, idGen.next(), attr, innerEnv).withXmlSource(xml, attrName));
			}
		}

		if (isRef) return ArpSeed.createSimple(typeName, key, value, env).withXmlSource(xml);

		for (node in xml) {
			switch (node.nodeType) {
				case XmlType.Element:
					acceptsTextNodeValue = false;
					if (node.nodeName == "env") {
						innerEnv = parseEnv(node, innerEnv);
					} else {
						if (children == null) children = [];
						children.push(parseInternal(node, idGen.next(), innerEnv));
					}
				case XmlType.PCData, XmlType.CData:
					if (textNodeValue == null) textNodeValue = "";
					textNodeValue += node.nodeValue;
				case _: // ignore
			}
		}

		if (value == null && acceptsTextNodeValue) value = textNodeValue;
		if (children == null) children = [];
		if (value != null) children.push(ArpSeed.createVerbatim("value", key, value, innerEnv).withXmlSource(xml, "value"));
		return ArpSeed.createComplex(typeName, className, name, key, heat, children, env).withXmlSource(xml);
	}

	private function parseEnv(xml:Xml, env:ArpSeedEnv):ArpSeedEnv {
		var innerEnv:ArpSeedEnv = env;
		var idGen:ArpIdGenerator = new ArpIdGenerator();
		var name:String = null;
		var value:String = null;
		var seeds:Array<ArpSeed> = [];
		for (attrName in xml.attributes()) {
			var attr:String = xml.get(attrName);
			switch (attrName) {
				case "name": name = attr;
				case "value": value = attr;
				case _: seeds.push(ArpSeed.createSimple(attrName, idGen.next(), attr, env).withXmlSource(xml, attrName));
			}
		}
		for (node in xml) {
			switch (node.nodeType) {
				case XmlType.Element:
					if (node.nodeName == "env") {
						innerEnv = parseEnv(node, innerEnv);
					} else {
						seeds.push(parseInternal(node, idGen.next(), innerEnv));
					}
				case XmlType.PCData, XmlType.CData:
					if (value == null) value = "";
					value += node.nodeValue;
				case _: // ignore
			}
		}
		env.addSeeds(name, value, seeds);
		return env;
	}
}

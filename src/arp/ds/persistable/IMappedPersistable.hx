package arp.ds.persistable;

import arp.persistable.IPersistable;

/**
 * ...
 * @author kaikoga
 */
interface IMappedPersistable extends IPersistable {

	function clonePersistable(name:String):IMappedPersistable;

}

package arp.ds;

import arp.ds.access.IMapAmend;
import arp.ds.access.IMapRemove;
import arp.ds.access.IMapRead;
import arp.ds.access.IMapWrite;
import arp.ds.access.IMapResolve;

interface IMap<K, V>
extends IMapRead<K, V>
extends IMapWrite<K, V>
extends IMapRemove<K, V>
extends IMapResolve<K, V>
extends IMapAmend<K, V>
{
}

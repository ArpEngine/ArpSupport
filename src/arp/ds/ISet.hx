package arp.ds;

import arp.ds.access.ISetAmend;
import arp.ds.access.ISetRemove;
import arp.ds.access.ISetRead;
import arp.ds.access.ISetWrite;

interface ISet<V>
extends ISetRead<V>
extends ISetWrite<V>
extends ISetRemove<V>
extends ISetAmend<V>
{
}

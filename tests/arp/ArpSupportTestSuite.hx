package arp;

import arp.iterators.StepToIteratorCase;
import arp.iterators.StepIteratorCase;
import arp.io.FifoCase;
import arp.io.BytesToolCase;
import arp.io.OutputWrapperCase;
import arp.io.InputWrapperCase;
import arp.ds.ListCase;
import arp.ds.MapCase;
import arp.ds.OmapCase;
import arp.ds.SetCase;
import arp.ds.impl.VoidCollectionCase;
import arp.ds.lambda.ListOpCase;
import arp.ds.lambda.MapOpCase;
import arp.ds.lambda.OmapOpCase;
import arp.ds.lambda.SetOpCase;
import arp.ds.proxy.ListProxyCase;
import arp.ds.proxy.ListSelfProxyCase;
import arp.ds.proxy.MapProxyCase;
import arp.ds.proxy.MapSelfProxyCase;
import arp.ds.proxy.OmapProxyCase;
import arp.ds.proxy.OmapSelfProxyCase;
import arp.ds.proxy.ProxyCaseUtilCase;
import arp.ds.proxy.SetProxyCase;
import arp.ds.proxy.SetSelfProxyCase;
import arp.events.ArpSignalCase;
import arp.iterators.ERegIteratorCase;
import arp.persistable.PersistIoCase;
import arp.seed.ArpSeedCase;
import arp.seed.ArpSeedEnvCase;
import arp.task.TaskRunnerCase;
import arp.utils.ArpStringUtilCase;
import arp.utils.StringBufferCase;
import picotest.PicoTestRunner;

import arp.testParams.DsImplProviders.*;
import arp.testParams.IoProviders.*;
import arp.testParams.PersistIoProviders.*;

class ArpSupportTestSuite {

	public static function addTo(r:PicoTestRunner) {
		r.load(ERegIteratorCase);
		r.load(StepIteratorCase);
		r.load(StepToIteratorCase);

		r.load(ArpStringUtilCase);
		r.load(StringBufferCase);

		r.load(BytesToolCase);
		r.load(FifoCase);
		r.load(InputWrapperCase, inputProvider());
		r.load(OutputWrapperCase, outputProvider());

		r.load(IntSetCase, setProvider());
		r.load(IntListCase, listProvider());
		r.load(StringIntMapCase, mapProvider());
		r.load(StringIntOmapCase, omapProvider());

		r.load(VoidCollectionCase);

		r.load(SetOpCase, setProvider());
		r.load(ListOpCase, listProvider());
		r.load(MapOpCase, mapProvider());
		r.load(OmapOpCase, omapProvider());

		r.load(IntSetCase, adapterSetProvider());
		r.load(IntListCase, adapterListProvider());
		r.load(StringIntMapCase, adapterMapProvider());
		r.load(StringIntOmapCase, adapterOmapProvider());

		r.load(SetOpCase, adapterSetProvider());
		r.load(ListOpCase, adapterListProvider());
		r.load(MapOpCase, adapterMapProvider());
		r.load(OmapOpCase, adapterOmapProvider());

		r.load(ProxyCaseUtilCase);

		r.load(SetProxyCase, setProvider());
		r.load(ListProxyCase, listProvider());
		r.load(MapProxyCase, mapProvider());
		r.load(OmapProxyCase, omapProvider());

		r.load(SetSelfProxyCase, setProvider());
		r.load(ListSelfProxyCase, listProvider());
		r.load(MapSelfProxyCase, mapProvider());
		r.load(OmapSelfProxyCase, omapProvider());

		r.load(IntSetCase, proxySetProvider());
		r.load(IntListCase, proxyListProvider());
		r.load(StringIntMapCase, proxyMapProvider());
		r.load(StringIntOmapCase, proxyOmapProvider());

		r.load(SetOpCase, proxySetProvider());
		r.load(ListOpCase, proxyListProvider());
		r.load(MapOpCase, proxyMapProvider());
		r.load(OmapOpCase, proxyOmapProvider());

		r.load(ArpSignalCase);

		r.load(TaskRunnerCase);

		r.load(PersistIoCase, persistIoProvider());

		r.load(ArpSeedEnvCase);
		r.load(ArpSeedCase);
	}


}

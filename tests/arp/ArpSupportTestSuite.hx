package arp;

import arp.curve.impl.CurveBezier2Case;
import arp.curve.impl.CurveBezier3Case;
import arp.curve.impl.CurveCubicAltCase;
import arp.curve.impl.CurveCubicCase;
import arp.curve.impl.CurveFlatCase;
import arp.curve.impl.CurveLinearCase;
import arp.curve.impl.CurveQuadraticAltCase;
import arp.curve.impl.CurveQuadraticCase;
import arp.ds.impl.VoidCollectionCase;
import arp.ds.lambda.ListOpCase;
import arp.ds.lambda.MapOpCase;
import arp.ds.lambda.OmapOpCase;
import arp.ds.lambda.SetOpCase;
import arp.ds.ListCase;
import arp.ds.MapCase;
import arp.ds.OmapCase;
import arp.ds.proxy.ListProxyCase;
import arp.ds.proxy.ListSelfProxyCase;
import arp.ds.proxy.MapProxyCase;
import arp.ds.proxy.MapSelfProxyCase;
import arp.ds.proxy.OmapProxyCase;
import arp.ds.proxy.OmapSelfProxyCase;
import arp.ds.proxy.ProxyCaseUtilCase;
import arp.ds.proxy.SetProxyCase;
import arp.ds.proxy.SetSelfProxyCase;
import arp.ds.SetCase;
import arp.events.ArpSignalCase;
import arp.events.ArpSignalToolsCase;
import arp.io.BytesToolCase;
import arp.io.FifoCase;
import arp.io.InputWrapperCase;
import arp.io.OutputWrapperCase;
import arp.iterators.CompositeIteratorCase;
import arp.iterators.EmptyIteratorCase;
import arp.iterators.ERegIteratorCase;
import arp.iterators.StepIteratorCase;
import arp.iterators.StepToIteratorCase;
import arp.persistable.AnonPersistIoCase;
import arp.persistable.ArrayPersistIoCase;
import arp.persistable.JsonPersistIoCase;
import arp.persistable.PackedPersistIoCase;
import arp.persistable.PersistIoCase;
import arp.persistable.VerbosePersistIoCase;
import arp.seed.ArpSeedCase;
import arp.seed.ArpSeedEnvCase;
import arp.task.TaskRunnerCase;
import arp.testParams.DsImplProviders.*;
import arp.testParams.IoProviders.*;
import arp.testParams.PersistIoProviders.*;
import arp.utils.ArpIntUtilCase;
import arp.utils.ArpStringUtilCase;
import arp.utils.FormatTextCase;
import arp.utils.StringBufferCase;
import picotest.PicoTestRunner;

class ArpSupportTestSuite {

	public static function addTo(r:PicoTestRunner) {
		r.load(EmptyIteratorCase);
		r.load(ERegIteratorCase);
		r.load(StepIteratorCase);
		r.load(StepToIteratorCase);
		r.load(CompositeIteratorCase);

		r.load(ArpIntUtilCase);
		r.load(ArpStringUtilCase);
		r.load(StringBufferCase);
		r.load(FormatTextCase);

		r.load(CurveBezier2Case);
		r.load(CurveBezier3Case);
		r.load(CurveCubicCase);
		r.load(CurveCubicAltCase);
		r.load(CurveQuadraticCase);
		r.load(CurveQuadraticAltCase);
		r.load(CurveFlatCase);
		r.load(CurveLinearCase);

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
		r.load(ArpSignalToolsCase);

		r.load(TaskRunnerCase);

		r.load(PersistIoCase, persistIoProvider());
		r.load(AnonPersistIoCase);
		r.load(ArrayPersistIoCase);
		r.load(JsonPersistIoCase);
		r.load(PackedPersistIoCase);
		r.load(VerbosePersistIoCase);

		r.load(ArpSeedEnvCase);
		r.load(ArpSeedCase);
	}


}

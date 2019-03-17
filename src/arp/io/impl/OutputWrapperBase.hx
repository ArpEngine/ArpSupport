package arp.io.impl;

import haxe.io.Output;

#if (flash || js)
typedef OutputWrapperBase<T:Output> = arp.io.impl.UnsafeOutputWrapperBase<T>;
#else
typedef OutputWrapperBase<T:Output> = arp.io.impl.UnsafeOutputWrapperBase<T>;
#end

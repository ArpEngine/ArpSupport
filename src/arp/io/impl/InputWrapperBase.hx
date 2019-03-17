package arp.io.impl;

import haxe.io.Input;

#if (flash || js)
typedef InputWrapperBase<T:Input> = arp.io.impl.UnsafeInputWrapperBase<T>;
#else
typedef InputWrapperBase<T:Input> = arp.io.impl.UnsafeInputWrapperBase<T>;
#end

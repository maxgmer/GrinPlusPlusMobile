import 'dart:ffi';

import 'dart:io';

class NativeApi {
  static final DynamicLibrary nativeAddLib = Platform.isAndroid
      ? DynamicLibrary.open('libnative_add.so')
      : DynamicLibrary.process();

  static final int Function() incrementAndLoadCounter = nativeAddLib
      .lookup<NativeFunction<Int32 Function()>>("native_add")
      .asFunction();
}
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'src/cronet.dart';

export 'src/cronet.dart';

final DynamicLibrary Function() loadLibrary = () {
  if (Platform.isWindows) {
    return DynamicLibrary.open('cronet.86.0.4240.198.dll');
  } else if (Platform.isMacOS) {
    return DynamicLibrary.open('libcronet.86.0.4240.198.dylib');
  } else if (Platform.isIOS) {
    return DynamicLibrary.process();
  } else if (Platform.isAndroid) {
    return DynamicLibrary.open('libcronet.86.0.4240.198.so');
  }
  throw UnimplementedError();
};

final _croNet = CroNet(loadLibrary());

final DynamicLibrary nativeInteropLib = DynamicLibrary.process();

final int Function(int x, int y) nativeAdd = nativeInteropLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();

class CronetFlutter {
  static String getVersionString() {
    print('nativeAdd ${nativeAdd(1, 2)}');
    var enginePtr = _croNet.Cronet_Engine_Create();
    try {
      return _croNet.Cronet_Engine_GetVersionString(enginePtr).cast<Utf8>().toDartString();
    } finally {
      _croNet.Cronet_Engine_Destroy(enginePtr);
    }
  }
}

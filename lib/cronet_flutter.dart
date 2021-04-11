import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'src/cronet.dart';

export 'src/cronet.dart';

final DynamicLibrary Function() loadLibrary = () {
  if (Platform.isWindows) {
    return DynamicLibrary.open('cronet.86.0.4240.198.dll');
  }
  throw UnimplementedError();
};

final _croNet = CroNet(loadLibrary());

class CronetFlutter {
  static String getVersionString() {
    var enginePtr = _croNet.Cronet_Engine_Create();
    var engineParamsPtr = _croNet.Cronet_EngineParams_Create();

    try {
      _croNet.Cronet_Engine_StartWithParams(enginePtr, engineParamsPtr);

      return _croNet.Cronet_Engine_GetVersionString(enginePtr).cast<Utf8>().toDartString();
    } finally {
      _croNet.Cronet_EngineParams_Destroy(engineParamsPtr);
      _croNet.Cronet_Engine_Destroy(enginePtr);
    }
  }
}

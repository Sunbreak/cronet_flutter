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

final DynamicLibrary nativeInteropLib = Platform.isAndroid
    ? DynamicLibrary.open('libcronet_flutter.so')
    : Platform.isWindows
        ? DynamicLibrary.open('cronet_flutter_plugin.dll')
        : DynamicLibrary.process();

final int Function(int x, int y) nativeAdd = nativeInteropLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();

class CronetFlutter {
  static String getVersionString() {
    print('nativeAdd ${nativeAdd(1, 2)}');
    var enginePtr = _croNet.Cronet_Engine_Create();
    try {
      return _croNet.Cronet_Engine_GetVersionString(enginePtr)
          .cast<Utf8>()
          .toDartString();
    } finally {
      _croNet.Cronet_Engine_Destroy(enginePtr);
    }
  }

  static CronetFlutter? _instance;

  factory CronetFlutter() => _instance ??= CronetFlutter._();

  late Pointer<Cronet_Engine> _engine;

  CronetFlutter._() {
    _engine = _croNet.Cronet_Engine_Create();
  }

  void dispose() {
    _croNet.Cronet_Engine_Destroy(_engine);
  }

  bool startEngine() {
    var engineParams = _croNet.Cronet_EngineParams_Create();
    var userAgent = "CronetSample/1".toNativeUtf8();
    try {
      _croNet.Cronet_EngineParams_user_agent_set(
          engineParams, userAgent.cast());
      _croNet.Cronet_EngineParams_enable_quic_set(engineParams, true);
      var r = _croNet.Cronet_Engine_StartWithParams(_engine, engineParams);
      return r == Cronet_RESULT.Cronet_RESULT_SUCCESS;
    } finally {
      _croNet.Cronet_EngineParams_Destroy(engineParams);
      malloc.free(userAgent);
    }
  }

  bool shutdownEngine() {
    var r = _croNet.Cronet_Engine_Shutdown(_engine);
    return r == Cronet_RESULT.Cronet_RESULT_SUCCESS;
  }
}

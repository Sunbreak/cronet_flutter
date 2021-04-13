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

  late Pointer<SampleExecutor> _sampleExecutor;

  CronetFlutter._() {
    _engine = _croNet.Cronet_Engine_Create();
    _sampleExecutor = _SampleExecutor_Create();
  }

  void dispose() {
    _SampleExecutor_Destory(_sampleExecutor);
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

  Pointer<Cronet_UrlRequest> _urlRequest = nullptr;

  Pointer<SampleUrlRequestCallback> _sampleUrlRequestCallback = nullptr;

  bool startRequest(String url) {
    if (_urlRequest != nullptr || _sampleUrlRequestCallback != nullptr) {
      return false;
    }

    _sampleUrlRequestCallback = _SampleUrlRequestCallback_Create();
    _urlRequest = _croNet.Cronet_UrlRequest_Create();

    var result = Cronet_RESULT.Cronet_RESULT_SUCCESS;
    result = _initUrlRequest(_urlRequest, url, _sampleUrlRequestCallback);
    if (result != Cronet_RESULT.Cronet_RESULT_SUCCESS) {
      return false;
    }

    result = _croNet.Cronet_UrlRequest_Start(_urlRequest);
    if (result != Cronet_RESULT.Cronet_RESULT_SUCCESS) {
      return false;
    }
    return true;
  }

  void stopRequest() {
    if (_urlRequest != nullptr) {
      _croNet.Cronet_UrlRequest_Destroy(_urlRequest);
    }
    if (_sampleUrlRequestCallback != nullptr) {
      _SampleUrlRequestCallback_Destory(_sampleUrlRequestCallback);
    }
  }

  int _initUrlRequest(
    Pointer<Cronet_UrlRequest> urlRequest,
    String url,
    Pointer<SampleUrlRequestCallback> sampleUrlRequestCallback,
  ) {
    var urlRequestParams = _croNet.Cronet_UrlRequestParams_Create();
    var urlUtf8 = url.toNativeUtf8();
    var httpMethodUtf8 = 'GET'.toNativeUtf8();

    try {
      _croNet.Cronet_UrlRequestParams_http_method_set(
          urlRequestParams, httpMethodUtf8.cast());
      return _croNet.Cronet_UrlRequest_InitWithParams(
        urlRequest,
        _engine,
        urlUtf8.cast(),
        urlRequestParams,
        _SampleUrlRequestCallback_GetUrlRequestCallback(
            sampleUrlRequestCallback),
        _SampleExecutor_GetExecutor(_sampleExecutor),
      );
    } finally {
      _croNet.Cronet_UrlRequestParams_Destroy(urlRequestParams);
      malloc.free(urlUtf8);
      malloc.free(httpMethodUtf8);
    }
  }
}

// --------------------------------------------------------------------------------------------------------------------------------

class SampleUrlRequestCallback extends Opaque {}

typedef _c_SampleUrlRequestCallback_Create = Pointer<SampleUrlRequestCallback>
    Function();

typedef _dart_SampleUrlRequestCallback_Create
    = Pointer<SampleUrlRequestCallback> Function();

final _SampleUrlRequestCallback_Create_ptr =
    nativeInteropLib.lookup<NativeFunction<_c_SampleUrlRequestCallback_Create>>(
        'SampleUrlRequestCallback_Create');
final _dart_SampleUrlRequestCallback_Create _SampleUrlRequestCallback_Create =
    _SampleUrlRequestCallback_Create_ptr.asFunction<
        _dart_SampleUrlRequestCallback_Create>();

// --------------------------------

typedef _c_SampleUrlRequestCallback_Destory = Void Function(
    Pointer<SampleUrlRequestCallback> request_callback);

typedef _dart_SampleUrlRequestCallback_Destory = void Function(
    Pointer<SampleUrlRequestCallback> request_callback);

final _SampleUrlRequestCallback_Destory_ptr = nativeInteropLib
    .lookup<NativeFunction<_c_SampleUrlRequestCallback_Destory>>(
        'SampleUrlRequestCallback_Destory');
final _dart_SampleUrlRequestCallback_Destory _SampleUrlRequestCallback_Destory =
    _SampleUrlRequestCallback_Destory_ptr.asFunction<
        _dart_SampleUrlRequestCallback_Destory>();

// --------------------------------

typedef _c_SampleUrlRequestCallback_GetUrlRequestCallback
    = Pointer<Cronet_UrlRequestCallback> Function(
        Pointer<SampleUrlRequestCallback> request_callback);

typedef _dart_SampleUrlRequestCallback_GetUrlRequestCallback
    = Pointer<Cronet_UrlRequestCallback> Function(
        Pointer<SampleUrlRequestCallback> request_callback);

final _SampleUrlRequestCallback_GetUrlRequestCallback_ptr = nativeInteropLib
    .lookup<NativeFunction<_c_SampleUrlRequestCallback_GetUrlRequestCallback>>(
        'SampleUrlRequestCallback_GetUrlRequestCallback');
final _dart_SampleUrlRequestCallback_GetUrlRequestCallback
    _SampleUrlRequestCallback_GetUrlRequestCallback =
    _SampleUrlRequestCallback_GetUrlRequestCallback_ptr.asFunction<
        _dart_SampleUrlRequestCallback_GetUrlRequestCallback>();

// --------------------------------------------------------------------------------------------------------------------------------

class SampleExecutor extends Opaque {}

typedef _c_SampleExecutor_Create = Pointer<SampleExecutor> Function();

typedef _dart_SampleExecutor_Create = Pointer<SampleExecutor> Function();

final _SampleExecutor_Create_ptr = nativeInteropLib
    .lookup<NativeFunction<_c_SampleExecutor_Create>>('SampleExecutor_Create');
final _dart_SampleExecutor_Create _SampleExecutor_Create =
    _SampleExecutor_Create_ptr.asFunction<_dart_SampleExecutor_Create>();

// --------------------------------

typedef _c_SampleExecutor_Destory = Void Function(
    Pointer<SampleExecutor> executor);

typedef _dart_SampleExecutor_Destory = void Function(
    Pointer<SampleExecutor> executor);

final _SampleExecutor_Destory_ptr =
    nativeInteropLib.lookup<NativeFunction<_c_SampleExecutor_Destory>>(
        'SampleExecutor_Destory');
final _dart_SampleExecutor_Destory _SampleExecutor_Destory =
    _SampleExecutor_Destory_ptr.asFunction<_dart_SampleExecutor_Destory>();

// --------------------------------

typedef _c_SampleExecutor_GetExecutor = Pointer<Cronet_Executor> Function(
    Pointer<SampleExecutor> executor);

typedef _dart_SampleExecutor_GetExecutor = Pointer<Cronet_Executor> Function(
    Pointer<SampleExecutor> executor);

final _SampleExecutor_GetExecutor_ptr =
    nativeInteropLib.lookup<NativeFunction<_c_SampleExecutor_GetExecutor>>(
        'SampleExecutor_GetExecutor');
final _dart_SampleExecutor_GetExecutor _SampleExecutor_GetExecutor =
    _SampleExecutor_GetExecutor_ptr.asFunction<
        _dart_SampleExecutor_GetExecutor>();

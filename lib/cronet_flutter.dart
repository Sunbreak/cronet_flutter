import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:flutter/widgets.dart';

import 'src/cronet.dart';

export 'src/cronet.dart';

part 'src/sample_executor.dart';
part 'src/sample_upload_data_provider.dart';
part 'src/sample_url_request_callback.dart';

final DynamicLibrary Function() loadLibrary = () {
  if (Platform.isWindows) {
    return DynamicLibrary.open('cronet.86.0.4240.198.dll');
  } else if (Platform.isMacOS) {
    return DynamicLibrary.open('libcronet.86.0.4240.198.dylib');
  } else if (Platform.isLinux) {
    return DynamicLibrary.open('${Platform.environment['EXE_DIR_PATH']}/lib/libcronet.86.0.4240.198.so');
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

final _initializeApi = nativeInteropLib.lookupFunction<
    IntPtr Function(Pointer<Void>),
    int Function(Pointer<Void>)>("InitDartApiDL");

class CronetFlutter {
  static String getVersionString() {
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

  late ReceivePort _receivePort;

  late StreamSubscription _subscription;

  late Pointer<Cronet_Engine> _engine;

  late Pointer<SampleExecutor> _sampleExecutor;

  CronetFlutter._() {
    _initNative();
    _engine = _croNet.Cronet_Engine_Create();
    _sampleExecutor = _SampleExecutor_Create();
  }

  void dispose() {
    _SampleExecutor_Destory(_sampleExecutor);
    _croNet.Cronet_Engine_Destroy(_engine);
    _disposeNative();
  }

  void _initNative() {
    WidgetsFlutterBinding.ensureInitialized();
    var nativeInited = _initializeApi(NativeApi.initializeApiDLData);
    // According to https://dart-review.googlesource.com/c/sdk/+/151525
    // flutter-1.24.0-10.1.pre+ has `DART_API_DL_MAJOR_VERSION = 2`
    assert(nativeInited == 0, 'DART_API_DL_MAJOR_VERSION != 2');
    _receivePort = ReceivePort();
    _subscription = _receivePort.listen(_handleNativeMessage);
    _registerSendPort(_receivePort.sendPort.nativePort);
  }

  final _registerSendPort = nativeInteropLib.lookupFunction<
      Void Function(Int64 sendPort),
      void Function(int sendPort)>('RegisterSendPort');

  void _disposeNative() {
    // TODO _unregisterReceivePort(_receivePort.sendPort.nativePort);
    _subscription.cancel();
    _receivePort.close();
  }

  void _handleNativeMessage(dynamic message) {
    print('_handleNativeMessage $message');
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

  Pointer<SampleUploadDataProvider> _sampleUploadDataProvider = nullptr;

  bool startRequest(String url) {
    if (_urlRequest != nullptr || _sampleUrlRequestCallback != nullptr) {
      return false;
    }

    _sampleUrlRequestCallback = _SampleUrlRequestCallback_Create();
    var _sampleUploadDataProvider = _SampleUploadDataProvider_Create();
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

    if (_sampleUploadDataProvider != nullptr) {
      _SampleUploadDataProvider_Destory(_sampleUploadDataProvider);
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

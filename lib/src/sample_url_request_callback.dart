part of '../cronet_flutter.dart';

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

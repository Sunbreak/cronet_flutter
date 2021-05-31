part of '../cronet_flutter.dart';

class SampleUploadDataProvider extends Opaque {}

typedef _c_SampleUploadDataProvider_Create = Pointer<SampleUploadDataProvider> Function();

typedef _dart_SampleUploadDataProvider_Create = Pointer<SampleUploadDataProvider> Function();

final _SampleUploadDataProvider_Create_ptr = nativeInteropLib
    .lookup<NativeFunction<_c_SampleUploadDataProvider_Create>>('SampleUploadDataProvider_Create');
final _dart_SampleUploadDataProvider_Create _SampleUploadDataProvider_Create =
    _SampleUploadDataProvider_Create_ptr.asFunction<_dart_SampleUploadDataProvider_Create>();

// --------------------------------

typedef _c_SampleUploadDataProvider_Destory = Void Function(
    Pointer<SampleUploadDataProvider> executor);

typedef _dart_SampleUploadDataProvider_Destory = void Function(
    Pointer<SampleUploadDataProvider> executor);

final _SampleUploadDataProvider_Destory_ptr =
    nativeInteropLib.lookup<NativeFunction<_c_SampleUploadDataProvider_Destory>>(
        'SampleUploadDataProvider_Destory');
final _dart_SampleUploadDataProvider_Destory _SampleUploadDataProvider_Destory =
    _SampleUploadDataProvider_Destory_ptr.asFunction<_dart_SampleUploadDataProvider_Destory>();
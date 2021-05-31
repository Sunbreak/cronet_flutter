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
    Pointer<SampleUploadDataProvider> provider);

typedef _dart_SampleUploadDataProvider_Destory = void Function(
    Pointer<SampleUploadDataProvider> provider);

final _SampleUploadDataProvider_Destory_ptr =
    nativeInteropLib.lookup<NativeFunction<_c_SampleUploadDataProvider_Destory>>(
        'SampleUploadDataProvider_Destory');
final _dart_SampleUploadDataProvider_Destory _SampleUploadDataProvider_Destory =
    _SampleUploadDataProvider_Destory_ptr.asFunction<_dart_SampleUploadDataProvider_Destory>();

// --------------------------------

typedef _c_SampleUploadDataProvider_GetData = Pointer<Int8> Function(
    Pointer<SampleUploadDataProvider> provider);

typedef _dart_SampleUploadDataProvider_GetData = Pointer<Int8> Function(
    Pointer<SampleUploadDataProvider> provider);

final _SampleUploadDataProvider_GetData_ptr =
    nativeInteropLib.lookup<NativeFunction<_c_SampleUploadDataProvider_GetData>>(
        'SampleUploadDataProvider_GetData');
final _dart_SampleUploadDataProvider_GetData _SampleUploadDataProvider_GetData =
    _SampleUploadDataProvider_GetData_ptr.asFunction<_dart_SampleUploadDataProvider_GetData>();

// --------------------------------

typedef _c_SampleUploadDataProvider_SetData = Void Function(
    Pointer<SampleUploadDataProvider> provider, Pointer<Int8> data, Int64 data_length);

typedef _dart_SampleUploadDataProvider_SetData = void Function(
    Pointer<SampleUploadDataProvider> provider, Pointer<Int8> data, int data_length);

final _SampleUploadDataProvider_SetData_ptr =
    nativeInteropLib.lookup<NativeFunction<_c_SampleUploadDataProvider_SetData>>(
        'SampleUploadDataProvider_SetData');
final _dart_SampleUploadDataProvider_SetData _SampleUploadDataProvider_SetData =
    _SampleUploadDataProvider_SetData_ptr.asFunction<_dart_SampleUploadDataProvider_SetData>();

// --------------------------------

typedef _c_SampleUploadDataProvider_GetUploadDataProvider = Pointer<Cronet_UploadDataProvider> Function(
    Pointer<SampleUploadDataProvider> provider);

typedef _dart_SampleUploadDataProvider_GetUploadDataProvider = Pointer<Cronet_UploadDataProvider> Function(
    Pointer<SampleUploadDataProvider> provider);

final _SampleUploadDataProvider_GetUploadDataProvider_ptr =
    nativeInteropLib.lookup<NativeFunction<_c_SampleUploadDataProvider_GetUploadDataProvider>>(
        'SampleUploadDataProvider_GetUploadDataProvider');
final _dart_SampleUploadDataProvider_GetUploadDataProvider _SampleUploadDataProvider_GetUploadDataProvider =
    _SampleUploadDataProvider_GetUploadDataProvider_ptr.asFunction<
        _dart_SampleUploadDataProvider_GetUploadDataProvider>();

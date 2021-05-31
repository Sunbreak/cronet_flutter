part of '../cronet_flutter.dart';

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

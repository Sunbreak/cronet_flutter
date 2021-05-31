#ifndef COMPONENTS_CRONET_NATIVE_SAMPLE_SAMPLE_UPLOAD_DATA_PROVIDER_H_
#define COMPONENTS_CRONET_NATIVE_SAMPLE_SAMPLE_UPLOAD_DATA_PROVIDER_H_

#include "cronet/cronet_c.h"
#include "dart_api/dart_api.h"

class SampleUploadDataProvider {
 public:
  SampleUploadDataProvider();
  ~SampleUploadDataProvider();

  // Gets Cronet_UploadProviderPtr implemented by |this|.
  Cronet_UploadDataProviderPtr GetUploadDataProvider();

  char* GetData() const { return data_; }

  void SetData(char* data, int64_t data_length) {
    data_ = data;
    data_length_ = data_length;
  }

 protected:
  int64_t GetLengthFunc();

  void ReadFunc(Cronet_UploadDataSinkPtr upload_data_sink,
                Cronet_BufferPtr buffer);

  void RewindFunc(Cronet_UploadDataSinkPtr upload_data_sink);

  void CloseFunc();

  static SampleUploadDataProvider* GetThis(Cronet_UploadDataProviderPtr self);

  // Implementation of Cronet_UploadDataProvider methods.
  static int64_t GetLengthFunc(Cronet_UploadDataProviderPtr self);

  static void ReadFunc(Cronet_UploadDataProviderPtr self,
                Cronet_UploadDataSinkPtr upload_data_sink,
                Cronet_BufferPtr buffer);
  
  static void RewindFunc(Cronet_UploadDataProviderPtr self,
                         Cronet_UploadDataSinkPtr upload_data_sink);

  static void CloseFunc(Cronet_UploadDataProviderPtr self);

  char* data_;

  int64_t data_length_;

  Cronet_UploadDataProviderPtr const provider_;
};

DART_EXPORT SampleUploadDataProvider* SampleUploadDataProvider_Create();

DART_EXPORT void SampleUploadDataProvider_Destory(SampleUploadDataProvider* provider);

DART_EXPORT char* SampleUploadDataProvider_GetData(SampleUploadDataProvider* provider);

DART_EXPORT void SampleUploadDataProvider_SetData(SampleUploadDataProvider* provider, char* data, int64_t data_length);

DART_EXPORT Cronet_UploadDataProviderPtr SampleUploadDataProvider_GetUploadDataProvider(SampleUploadDataProvider* provider);

#endif  // COMPONENTS_CRONET_NATIVE_SAMPLE_SAMPLE_UPLOAD_DATA_PROVIDER_H_
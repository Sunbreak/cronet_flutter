#ifndef COMPONENTS_CRONET_NATIVE_SAMPLE_SAMPLE_UPLOAD_DATA_PROVIDER_H_
#define COMPONENTS_CRONET_NATIVE_SAMPLE_SAMPLE_UPLOAD_DATA_PROVIDER_H_

#include "cronet/cronet_c.h"
#include "dart_api/dart_api.h"

class SampleUploadDataProvider {
 public:
  SampleUploadDataProvider();
  ~SampleUploadDataProvider();
};

DART_EXPORT SampleUploadDataProvider* SampleUploadDataProvider_Create();

DART_EXPORT void SampleUploadDataProvider_Destory(SampleUploadDataProvider* provider);

#endif  // COMPONENTS_CRONET_NATIVE_SAMPLE_SAMPLE_UPLOAD_DATA_PROVIDER_H_
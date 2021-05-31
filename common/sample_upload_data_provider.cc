#include "sample_upload_data_provider.hh"

SampleUploadDataProvider::SampleUploadDataProvider() = default;

SampleUploadDataProvider::~SampleUploadDataProvider() = default;

SampleUploadDataProvider* SampleUploadDataProvider_Create() {
  return new SampleUploadDataProvider();
}

void SampleUploadDataProvider_Destory(SampleUploadDataProvider* provider) {
  delete provider;
}
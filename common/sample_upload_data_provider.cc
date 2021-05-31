#include "sample_upload_data_provider.hh"

#include <string.h>

#include <iostream>

SampleUploadDataProvider::SampleUploadDataProvider()
    : provider_(Cronet_UploadDataProvider_CreateWith(
          SampleUploadDataProvider::GetLengthFunc,
          SampleUploadDataProvider::ReadFunc,
          SampleUploadDataProvider::RewindFunc,
          SampleUploadDataProvider::CloseFunc)) {
  Cronet_UploadDataProvider_SetClientContext(provider_, this);
}

SampleUploadDataProvider::~SampleUploadDataProvider() {
  Cronet_UploadDataProvider_Destroy(provider_);
}

Cronet_UploadDataProviderPtr SampleUploadDataProvider::GetUploadDataProvider() {
  return provider_;
}

int64_t SampleUploadDataProvider::GetLengthFunc() {
  std::cout << "GetLengthFunc called" << std::endl;
  return data_length_;
}

void SampleUploadDataProvider::ReadFunc(
    Cronet_UploadDataSinkPtr upload_data_sink,
    Cronet_BufferPtr buffer) {
  std::cout << "ReadFunc called" << std::endl;
  memcpy(Cronet_Buffer_GetData(buffer), data_, data_length_);
  bool final_chunk = false; // TODO multi-chunk
  Cronet_UploadDataSink_OnReadSucceeded(upload_data_sink, data_length_, final_chunk);
}

void SampleUploadDataProvider::RewindFunc(Cronet_UploadDataSinkPtr upload_data_sink) {
  std::cout << "RewindFunc called" << std::endl;
  // TODO Reset buffer index
  Cronet_UploadDataSink_OnRewindSucceeded(upload_data_sink);
}

void SampleUploadDataProvider::CloseFunc() {
  std::cout << "CloseFunc called" << std::endl;
  // TODO
}

/* static */
SampleUploadDataProvider* SampleUploadDataProvider::GetThis(
    Cronet_UploadDataProviderPtr self) {
  return static_cast<SampleUploadDataProvider*>(
      Cronet_UploadDataProvider_GetClientContext(self));
}

/* static */
int64_t SampleUploadDataProvider::GetLengthFunc(Cronet_UploadDataProviderPtr self) {
  return GetThis(self)->GetLengthFunc();
}

/* static */
void SampleUploadDataProvider::ReadFunc(
    Cronet_UploadDataProviderPtr self,
    Cronet_UploadDataSinkPtr upload_data_sink,
    Cronet_BufferPtr buffer) {
  GetThis(self)->ReadFunc(upload_data_sink, buffer);
}

/* static */
void SampleUploadDataProvider::RewindFunc(
    Cronet_UploadDataProviderPtr self,
    Cronet_UploadDataSinkPtr upload_data_sink) {
  GetThis(self)->RewindFunc(upload_data_sink);
}

/* static */
void SampleUploadDataProvider::CloseFunc(Cronet_UploadDataProviderPtr self) {
  GetThis(self)->CloseFunc();
}

SampleUploadDataProvider* SampleUploadDataProvider_Create() {
  return new SampleUploadDataProvider();
}

void SampleUploadDataProvider_Destory(SampleUploadDataProvider* provider) {
  delete provider;
}

char* SampleUploadDataProvider_GetData(SampleUploadDataProvider* provider) {
  return provider->GetData();
}

void SampleUploadDataProvider_SetData(SampleUploadDataProvider* provider, char* data, int64_t data_length) {
  return provider->SetData(data, data_length);
}

Cronet_UploadDataProviderPtr SampleUploadDataProvider_GetUploadDataProvider(SampleUploadDataProvider* provider) {
  return provider->GetUploadDataProvider();
}
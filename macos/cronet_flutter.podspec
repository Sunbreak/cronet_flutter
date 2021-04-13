#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint cronet_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'cronet_flutter'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.vendored_libraries = 'libcronet.86.0.4240.198.dylib'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'

  # Fix symbol not found when without use_framework!
  s.user_target_xcconfig = { 'OTHER_LDFLAGS' => '-ObjC -all_load' }
end

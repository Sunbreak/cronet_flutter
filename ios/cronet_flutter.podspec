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
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # telling CocoaPods not to remove framework
  s.preserve_paths = 'Cronet.framework'

  # telling linker to include framework
  s.user_target_xcconfig = { 'OTHER_LDFLAGS' => '-framework Cronet' }

  # including framework
  s.vendored_frameworks = 'Cronet.framework'
  
  # including system libraries
  s.libraries = 'c++', 'resolv'

  # including system frameworks
  s.frameworks = 'SystemConfiguration'
end

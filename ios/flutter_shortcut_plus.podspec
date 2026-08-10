#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_shortcut.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_shortcut_plus'
  s.version          = '1.1.2'
  s.summary          = 'Static & dynamic app shortcuts for Flutter.'
  s.description      = <<-DESC
Flutter plugin for creating static & dynamic app/conversation shortcuts on home screen.
                       DESC
  s.homepage         = 'https://github.com/tayoji-io/flutter_shortcut'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'tayoji' => 'tayoji.io@outlook.com' }
  s.source           = { :path => '.' }
  s.source_files = 'flutter_shortcut_plus/Sources/flutter_shortcut_plus/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_shortcut_method_channel.dart';

abstract class FlutterShortcutPlatform extends PlatformInterface {
  /// Constructs a FlutterShortcutPlatform.
  FlutterShortcutPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterShortcutPlatform _instance = MethodChannelFlutterShortcut();

  /// The default instance of [FlutterShortcutPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterShortcut].
  static FlutterShortcutPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterShortcutPlatform] when
  /// they register themselves.
  static set instance(FlutterShortcutPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

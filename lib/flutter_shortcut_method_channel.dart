import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_shortcut_platform_interface.dart';

/// An implementation of [FlutterShortcutPlatform] that uses method channels.
class MethodChannelFlutterShortcut extends FlutterShortcutPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_shortcut');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

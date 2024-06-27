
import 'flutter_shortcut_platform_interface.dart';

class FlutterShortcut {
  Future<String?> getPlatformVersion() {
    return FlutterShortcutPlatform.instance.getPlatformVersion();
  }
}

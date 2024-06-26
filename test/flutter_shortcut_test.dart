import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_shortcut/flutter_shortcut.dart';
import 'package:flutter_shortcut/flutter_shortcut_platform_interface.dart';
import 'package:flutter_shortcut/flutter_shortcut_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterShortcutPlatform
    with MockPlatformInterfaceMixin
    implements FlutterShortcutPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterShortcutPlatform initialPlatform = FlutterShortcutPlatform.instance;

  test('$MethodChannelFlutterShortcut is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterShortcut>());
  });

  test('getPlatformVersion', () async {
    FlutterShortcut flutterShortcutPlugin = FlutterShortcut();
    MockFlutterShortcutPlatform fakePlatform = MockFlutterShortcutPlatform();
    FlutterShortcutPlatform.instance = fakePlatform;

    expect(await flutterShortcutPlugin.getPlatformVersion(), '42');
  });
}

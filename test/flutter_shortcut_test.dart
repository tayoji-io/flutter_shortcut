import 'package:flutter_shortcut/flutter_shortcut.dart';
import 'package:flutter_shortcut/src/method_call/flutter_shortcut_method_call_handler.dart';
import 'package:flutter_shortcut/src/platform/flutter_shortcut_platform.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterShortcutPlatform
    with MockPlatformInterfaceMixin
    implements FlutterShortcutPlatform {
  @override
  Future<void> changeShortcutItemIcon(String id, String icon) {
    // TODO: implement changeShortcutItemIcon
    throw UnimplementedError();
  }

  @override
  Future<void> clearShortcutItems() {
    // TODO: implement clearShortcutItems
    throw UnimplementedError();
  }

  @override
  Future<Map<String, int>> getIconProperties() {
    // TODO: implement getIconProperties
    throw UnimplementedError();
  }

  @override
  Future<int?> getMaxShortcutLimit() {
    // TODO: implement getMaxShortcutLimit
    throw UnimplementedError();
  }

  @override
  Future<void> initialize(bool debug) {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<void> listenAction(ShortcutAction action) {
    // TODO: implement listenAction
    throw UnimplementedError();
  }

  @override
  Future<void> pushShortcutItem(ShortcutItem shortcut) {
    // TODO: implement pushShortcutItem
    throw UnimplementedError();
  }

  @override
  Future<void> pushShortcutItems(List<ShortcutItem> items) {
    // TODO: implement pushShortcutItems
    throw UnimplementedError();
  }

  @override
  Future<void> setShortcutItems(List<ShortcutItem> items) {
    // TODO: implement setShortcutItems
    throw UnimplementedError();
  }

  @override
  Future<void> updateShortcutItem(ShortcutItem shortcut) {
    // TODO: implement updateShortcutItem
    throw UnimplementedError();
  }

  @override
  Future<void> updateShortcutItems(List<ShortcutItem> items) {
    // TODO: implement updateShortcutItems
    throw UnimplementedError();
  }
}

void main() {
  final FlutterShortcutPlatform initialPlatform =
      FlutterShortcutPlatform.instance;

  test('$FlutterShortcutMethodCallHandler is the default instance', () {
    expect(initialPlatform, isInstanceOf<FlutterShortcutMethodCallHandler>());
  });

  test('getPlatformVersion', () async {
    MockFlutterShortcutPlatform fakePlatform = MockFlutterShortcutPlatform();
    FlutterShortcutPlatform.instance = fakePlatform;

    expect(await FlutterShortcut.getMaxShortcutLimit(), '42');
  });
}

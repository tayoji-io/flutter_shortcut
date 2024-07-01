import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shortcut_plus/src/helper/helper.dart';
import 'package:flutter_shortcut_plus/src/platform/flutter_shortcut_platform.dart';

class FlutterShortcutMethodCallHandler extends FlutterShortcutPlatform {
  final _channel = const MethodChannel('com.tayoji.flutter_shortcut');

  MethodChannel get channel => _channel;

  @override
  Future<void> initialize(bool debug) async {
    Map<String, String> initValue = {
      'debug': kReleaseMode ? false.toString() : debug.toString(),
    };
    await channel.invokeMethod('initialize', [initValue]);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> listenAction(ShortcutAction actionHandler) async {
    channel.setMethodCallHandler((MethodCall call) async {
      assert(call.method == 'launch');
      actionHandler(call.arguments);
    });
    final String? action =
        await channel.invokeMethod<String>('getLaunchAction');
    if (action != null) {
      actionHandler(action);
    }
  }

  @override
  Future<int?> getMaxShortcutLimit() {
    return channel.invokeMethod<int>('getMaxShortcutLimit');
  }

  @override
  Future<Map<String, int>> getIconProperties() async {
    return Map.castFrom<dynamic, dynamic, String, int>(
        await channel.invokeMethod('getIconProperties'));
  }

  @override
  Future<void> setShortcutItems(List<ShortcutItem> items) async {
    final List<Map<String, dynamic>> itemsList =
        items.map((item) => item.serialize()).toList();
    await channel.invokeMethod<void>('setShortcutItems', itemsList);
  }

  @override
  Future<void> clearShortcutItems() async {
    await channel.invokeMethod<void>('clearShortcutItems');
  }

  @override
  Future<void> pushShortcutItem(ShortcutItem shortcut) async {
    final Map<String, dynamic> item = shortcut.serialize();
    await channel.invokeMethod<void>('pushShortcutItem', [item]);
  }

  @override
  Future<void> pushShortcutItems(List<ShortcutItem> items) async {
    final List<Map<String, dynamic>> itemsList =
        items.map((item) => item.serialize()).toList();
    await channel.invokeMethod<void>('pushShortcutItems', itemsList);
  }

  @override
  Future<void> updateShortcutItems(List<ShortcutItem> items) async {
    final List<Map<String, dynamic>> itemsList =
        items.map((item) => item.serialize()).toList();
    await channel.invokeMethod<void>('updateShortcutItems', itemsList);
  }

  @override
  Future<void> updateShortcutItem(ShortcutItem shortcut) async {
    final Map<String, dynamic> item = shortcut.serialize();
    await channel.invokeMethod<void>('updateShortcutItem', [item]);
  }

  @override
  Future<void> changeShortcutItemIcon(String id, String icon) async {
    await channel.invokeMethod<void>('changeShortcutItemIcon', [id, icon]);
  }
}

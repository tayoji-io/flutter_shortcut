/* 

              Copyright (c) 2021 divshekhar (Divyanshu Shekhar). 
                            All rights reserved.

The plugin is governed by the BSD-3-clause License. Please see the LICENSE file
for more details.

*/

import 'dart:async';

import 'package:flutter_shortcut/src/helper/helper.dart';
import 'package:flutter_shortcut/src/platform/flutter_shortcut_platform.dart';

export 'package:flutter_shortcut/src/helper/helper.dart';

class FlutterShortcut {
  FlutterShortcut._();

  /// [initialize] initializes the flutter_shortcuts plugin.
  static Future<void> initialize({bool debug = true}) async {
    FlutterShortcutPlatform.instance.initialize(debug);
  }

  /// [listenAction] performs action when shortcut is initiated.
  static Future<void> listenAction(ShortcutAction action) async {
    FlutterShortcutPlatform.instance.listenAction(action);
  }

  /// [getMaxShortcutLimit] returns the maximum number of static or dynamic
  /// shortcuts that each launcher icon can have at a time.
  static Future<int?> getMaxShortcutLimit() {
    return FlutterShortcutPlatform.instance.getMaxShortcutLimit();
  }

  /// [getIconProperties] returns the "maxHeight" and "maxWidth" of the shortcut icon.
  /// Example: {"maxHeight": 250, "maxWidth": 200}
  static Future<Map<String, int>> getIconProperties() {
    return FlutterShortcutPlatform.instance.getIconProperties();
  }

  /// [setShortcutItems] will set all the shortcut items.
  static Future<void> setShortcutItems(
      {required List<ShortcutItem> shortcutItems}) async {
    return FlutterShortcutPlatform.instance.setShortcutItems(shortcutItems);
  }

  /// [clearShortcutItems] will remove all the shortcut items.
  static Future<void> clearShortcutItems() async {
    return FlutterShortcutPlatform.instance.clearShortcutItems();
  }

  /// [pushShortcutItem] will push a new shortcut item.
  /// If there is already a dynamic or pinned shortcut with the same ID,
  /// the shortcut will be updated and pushed at the end of the shortcut list.
  static Future<void> pushShortcutItem({required ShortcutItem shortcut}) async {
    return FlutterShortcutPlatform.instance.pushShortcutItem(shortcut);
  }

  /// [pushShortcutItems] updates dynamic or pinned shortcuts with same IDs
  /// and pushes new shortcuts with different IDs.
  static Future<void> pushShortcutItems(
      {required List<ShortcutItem> shortcutList}) async {
    return FlutterShortcutPlatform.instance.pushShortcutItems(shortcutList);
  }

  /// [updateShortcutItems] updates shortcut items.
  /// If the IDs of the shortcuts are not same, no changes will be reflected.
  static Future<void> updateShortcutItems(
      {required List<ShortcutItem> shortcutList}) async {
    return FlutterShortcutPlatform.instance.updateShortcutItems(shortcutList);
  }

  /// [updateShortcutItem] updates a single shortcut item based on id.
  /// If the ID of the shortcut is not same, no changes will be reflected.
  static Future<void> updateShortcutItem(
      {required ShortcutItem shortcut}) async {
    return FlutterShortcutPlatform.instance.updateShortcutItem(shortcut);
  }

  /// [changeShortcutItemIcon] will change the icon of the shortcut based on id.
  /// If the ID of the shortcut is not same, no changes will be reflected.
  static Future<void> changeShortcutItemIcon(
      {required String id, required String icon}) async {
    return FlutterShortcutPlatform.instance.changeShortcutItemIcon(id, icon);
  }
}

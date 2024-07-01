import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_shortcut/flutter_shortcut.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _action;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    FlutterShortcut.listenAction((action) {
      setState(() {
        _action = action;
      });
    });
    setShortcutItems();

    if (!mounted) return;
  }

  void setShortcutItems() {
    FlutterShortcut.setShortcutItems(
      shortcutItems: <ShortcutItem>[
        const ShortcutItem(
          id: "1",
          action: 'shortcut.scan',
          shortLabel: 'Scan code',
          icon: "assets/scan.png",
          shortcutIconAsset: ShortcutIconAsset.flutterAsset,
        ),
      ],
    );
  }

  void clearShortcutItems() {
    FlutterShortcut.clearShortcutItems();
  }

  void pushShortcutItem() {
    FlutterShortcut.pushShortcutItem(
        shortcut: const ShortcutItem(
            id: '2',
            action: 'shortcut.messages',
            shortLabel: 'Messages',
            icon: 'message',
            shortcutIconAsset: ShortcutIconAsset.nativeAsset));
  }

  void updateShortcutItem() {
    FlutterShortcut.updateShortcutItem(
        shortcut: const ShortcutItem(
      id: '1',
      action: 'shortcut.scan',
      shortLabel: 'Scan code update',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          Text('listenAction: ${_action ?? ''}'),
          ...([
            ListItem("setShortcutItems", setShortcutItems),
            ListItem("clearShortcutItems", clearShortcutItems),
            ListItem("pushShortcutItem", pushShortcutItem),
            ListItem("updateShortcutItem", updateShortcutItem),
          ].map((item) {
            return FilledButton(
                onPressed: item.onPressed, child: Text(item.title));
          }).toList())
        ]),
      ),
    );
  }
}

class ListItem {
  final String title;
  VoidCallback onPressed;
  ListItem(this.title, this.onPressed);
}

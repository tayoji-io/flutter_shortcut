# flutter_shortcut

Flutter plugin for creating static & dynamic app/conversation shortcuts on home screen. Supports iOS android


## Fork

[Address of the original author](https://pub.dev/packages/flutter_shortcuts)
Adapt iOS based on this code



## Demo

|<img height=576 src="/screen_1.gif"/>|
|---|

## Quick Start

### Step 1: Include plugin to your project

```yml
dependencies:
  flutter_shortcut_plus: <latest version>
```

Run pub get and get packages.

### Step 2: Initialize Flutter Shortcuts (Optional)

Officially Supported Platforms/Implementations:

- Android

```dart
FlutterShortcut.initialize(debug: true);
```

## Example

### Define Shortcut Action

```dart
FlutterShortcut.listenAction((String incomingAction) {
    setState(() {
    if (incomingAction != null) {
        action = incomingAction;
    }
  });
});
```

### Get Max Shortcut Limit

Return the maximum number of static and dynamic shortcuts that each launcher icon can have at a time.

Officially Supported Platforms/Implementations:

- Android

```dart
int? result = await FlutterShortcut.getMaxShortcutLimit();
```

### Shortcut Icon Asset

Flutter Shortcuts allows you to create shortcut icon from both android `drawable` or `mipmap` and flutter Assets.

- Android resources, `drawable` or `mipmap`.
- iOS resources , Assets.xcassets

use: `ShortcutIconAsset.nativeAsset`

```dart
ShortcutItem(
  id: "2",
  action: 'shortcut.messages',
  shortLabel: 'Messages',
  icon: "message",
  shortcutIconAsset: ShortcutIconAsset.nativeAsset,
),
```

* If you want to create shortcut icon from flutter asset. (DEFAULT)

use: `ShortcutIconAsset.flutterAsset`

```dart
ShortcutItem(
  id: "1",
  action: 'shortcut.scan',
  shortLabel: 'Scan code',
  icon: 'assets/scan.png',
  shortcutIconAsset: ShortcutIconAsset.flutterAsset,
),
```

### Set shortcut items

Publishes the list of shortcuts. All existing shortcuts will be replaced.

```dart
FlutterShortcut.setShortcutItems(
  shortcutItems: <ShortcutItem>[
    const ShortcutItem(
      id: "1",
      action: 'shortcut.scan',
      shortLabel: 'Scan code',
      icon: 'assets/scan.png',
    ),
    const ShortcutItem(
      id: "2",
      action: 'shortcut.messages',
      shortLabel: 'Messages',
      icon: "messages",
      shortcutIconAsset: ShortcutIconAsset.nativeAsset,
    ),
  ],
),
```

### Clear shortcut item

Delete all dynamic shortcuts from the app.

```dart
FlutterShortcut.clearShortcutItems();
```

### Push Shortcut Item

Push a new shortcut item. If there is already a dynamic or pinned shortcut with the same **ID**, the shortcut will be updated and pushed at the end of the shortcut list.

```dart
FlutterShortcut.pushShortcutItem(
  shortcut: ShortcutItem(
      id: "2",
      action: 'shortcut.messages',
      shortLabel: 'Messages',
      icon: "messages",
      shortcutIconAsset: ShortcutIconAsset.nativeAsset,
    ),
);
```

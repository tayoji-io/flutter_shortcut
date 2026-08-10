## 1.1.2

* Android: tapping a shortcut no longer restarts the app. The shortcut intent uses
  `SINGLE_TOP` instead of `CLEAR_TASK`, and a warm launch delivers the action through
  `onNewIntent` to the existing `listenAction` callback.

## 1.1.1

* Android: drop the legacy `package` attribute from the manifest and always set `namespace` (required by AGP 8+).

## 1.1.0

* iOS: Swift Package Manager support (CocoaPods still works).

## 1.0.1

* iOS support.

## 0.0.1

* TODO: Describe initial release.

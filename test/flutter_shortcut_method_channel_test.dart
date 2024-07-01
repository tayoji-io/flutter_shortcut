import 'package:flutter/services.dart';
import 'package:flutter_shortcut_plus/src/method_call/flutter_shortcut_method_call_handler.dart';
import 'package:flutter_shortcut_plus/src/platform/flutter_shortcut_platform.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  FlutterShortcutPlatform platform = FlutterShortcutMethodCallHandler();
  const MethodChannel channel = MethodChannel('com.tayoji.flutter_shortcut');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getMaxShortcutLimit', () async {
    expect(await platform.getMaxShortcutLimit(), '42');
  });
}

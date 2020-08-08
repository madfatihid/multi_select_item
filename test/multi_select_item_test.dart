import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_select_item/multi_select_item.dart';

void main() {
  const MethodChannel channel = MethodChannel('multi_select_item');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}

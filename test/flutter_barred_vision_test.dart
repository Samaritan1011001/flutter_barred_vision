import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_barred_vision/flutter_barred_vision.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_barred_vision');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

//  test('getPlatformVersion', () async {
//    expect(await FlutterBarredVision, '42');
//  });
}

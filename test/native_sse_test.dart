import 'package:flutter_test/flutter_test.dart';
import 'package:native_sse/native_sse.dart';
import 'package:native_sse/native_sse_platform_interface.dart';
import 'package:native_sse/native_sse_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeSsePlatform
    with MockPlatformInterfaceMixin
    implements NativeSsePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NativeSsePlatform initialPlatform = NativeSsePlatform.instance;

  test('$MethodChannelNativeSse is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeSse>());
  });

  test('getPlatformVersion', () async {
    NativeSse nativeSsePlugin = NativeSse();
    MockNativeSsePlatform fakePlatform = MockNativeSsePlatform();
    NativeSsePlatform.instance = fakePlatform;

    expect(await nativeSsePlugin.getPlatformVersion(), '42');
  });
}

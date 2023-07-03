import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_sse_platform_interface.dart';

/// An implementation of [NativeSsePlatform] that uses method channels.
class MethodChannelNativeSse4 extends NativeSsePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_sse');

  final eventChannel = const EventChannel('native_sse_event/link4');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Stream<dynamic> startListenSSE(String url, Map<String, String> headers) {
    return eventChannel.receiveBroadcastStream({
      'url': url,
      ...headers,
    });
  }
}

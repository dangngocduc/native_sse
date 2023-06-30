import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_sse_method_channel.dart';

abstract class NativeSsePlatform extends PlatformInterface {
  /// Constructs a NativeSsePlatform.
  NativeSsePlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeSsePlatform _instance = MethodChannelNativeSse();

  /// The default instance of [NativeSsePlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeSse].
  static NativeSsePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeSsePlatform] when
  /// they register themselves.
  static set instance(NativeSsePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Stream<dynamic> startListenSSE(String url, Map<String, String> headers) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

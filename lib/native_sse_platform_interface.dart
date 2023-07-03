import 'package:native_sse/native_sse_method_channel_2.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_sse_method_channel.dart';
import 'native_sse_method_channel_3.dart';
import 'native_sse_method_channel_4.dart';

abstract class NativeSsePlatform extends PlatformInterface {
  /// Constructs a NativeSsePlatform.
  NativeSsePlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeSsePlatform _instance = MethodChannelNativeSse();
  static NativeSsePlatform _instance2 = MethodChannelNativeSse2();
  static NativeSsePlatform _instance3 = MethodChannelNativeSse3();
  static NativeSsePlatform _instance4 = MethodChannelNativeSse4();

  /// The default instance of [NativeSsePlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeSse].
  static NativeSsePlatform get instance => _instance;

  static NativeSsePlatform get instance2 => _instance2;

  static NativeSsePlatform get instance3 => _instance3;

  static NativeSsePlatform get instance4 => _instance4;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeSsePlatform] when
  /// they register themselves.
  // static set instance(NativeSsePlatform instance) {
  //   PlatformInterface.verifyToken(instance, _token);
  //   _instance = instance;
  // }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Stream<dynamic> startListenSSE(String url, Map<String, String> headers) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'native_sse_platform_interface.dart';

class NativeSse {
  Future<String?> getPlatformVersion() {
    return NativeSsePlatform.instance.getPlatformVersion();
  }

  Stream startListenSSE(
      {required String url, required Map<String, String> headers}) {
    return NativeSsePlatform.instance.startListenSSE(url, headers);
  }
}

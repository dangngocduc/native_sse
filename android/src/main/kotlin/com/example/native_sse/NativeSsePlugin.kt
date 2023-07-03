package com.example.native_sse

import android.net.Uri
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.net.HttpURLConnection
import java.net.URL

/** NativeSsePlugin */
class NativeSsePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var eventChannel : EventChannel
  private lateinit var eventChannel2 : EventChannel
  private lateinit var eventChannel3 : EventChannel
  private lateinit var eventChannel4 : EventChannel


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "native_sse")
    channel.setMethodCallHandler(this)

    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "native_sse_event")
    eventChannel.setStreamHandler(InternalStreamHandler());

    eventChannel2 = EventChannel(flutterPluginBinding.binaryMessenger, "native_sse_event/link2")
    eventChannel2.setStreamHandler(InternalStreamHandler());

    eventChannel3 = EventChannel(flutterPluginBinding.binaryMessenger, "native_sse_event/link3")
    eventChannel3.setStreamHandler(InternalStreamHandler());

    eventChannel4 = EventChannel(flutterPluginBinding.binaryMessenger, "native_sse_event/link4")
    eventChannel4.setStreamHandler(InternalStreamHandler());
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "start_listen") {

      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

}

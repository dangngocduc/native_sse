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
class NativeSsePlugin: FlutterPlugin, MethodCallHandler, StreamHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var eventChannel : EventChannel
  private  var eventsSink : EventChannel.EventSink? = null
  private  var conn : HttpURLConnection? = null


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "native_sse")
    channel.setMethodCallHandler(this)

    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "native_sse_event")
    eventChannel.setStreamHandler(this);
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

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    if (eventsSink != null) {
      eventsSink?.error("000", "Có listen mới", "")
    }
    println("Start onListen")
    eventsSink = events;
    CoroutineScope(Dispatchers.IO).launch {
      conn =  (URL(arguments as String).openConnection() as HttpURLConnection).also {
        it.setRequestProperty("Accept", "text/event-stream")
        it.doInput = true
      }
      conn?.connect()
      val inputReader = conn?.inputStream?.bufferedReader()
      while (true) {
        val data = inputReader?.readLine();
        if (eventsSink != null) {
          CoroutineScope(Dispatchers.Main).launch {
            eventsSink?.success(data)
          }
        }
      }
    }
  }

  override fun onCancel(arguments: Any?) {
    eventsSink = null
    conn?.disconnect()
  }
}

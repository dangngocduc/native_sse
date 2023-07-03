package com.example.native_sse

import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.net.HttpURLConnection
import java.net.URL

class InternalStreamHandler : EventChannel.StreamHandler {

    private  var eventsSink : EventChannel.EventSink? = null
    private  var conn : HttpURLConnection? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        if (eventsSink != null) {
            eventsSink?.error("000", "Có listen mới", "")
        }
        println("Start onListen ${arguments?.javaClass}")
        eventsSink = events;

        var arg : Map<String, String> = arguments as Map<String, String>

        CoroutineScope(Dispatchers.IO).launch {
            try {
                conn =  (URL(arg["url"] as String).openConnection() as HttpURLConnection).also {
                    it.setRequestProperty("Accept", "text/event-stream")
                    arg.keys.forEach {
                        s ->
                        run {
                            if (s != "url") {
                                it.setRequestProperty(s, arg[s])
                            }
                        }
                    }
                    it.doInput = true
                }
                conn?.connect()
                val inputReader = conn?.inputStream?.bufferedReader()
                while (true) {
                    if (eventsSink != null) {
                        val data = inputReader?.readLine();
                        CoroutineScope(Dispatchers.Main).launch {
                            eventsSink?.success(data)
                        }
                    }
                }
            } catch (error : Exception) {
                if (eventsSink != null) {
                    CoroutineScope(Dispatchers.Main).launch {
                        eventsSink?.error("Error When Listen", error.message, error)
                    }
                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        eventsSink = null
        try {
            conn?.disconnect()
        } catch (error : Exception) {

        }
    }
}
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/services.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:native_sse/native_sse.dart';
import 'package:native_sse/native_sse_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String data = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    NativeSsePlatform.instance.startListenSSE(
      'https://sse-demo.netlify.app/sse',
      {},
    ).listen((event) {
      developer.log('event: $event', name: 'Main');
      if (event != null && event.toString().isNotEmpty == true) {
        setState(() {
          data = '${data}\n{$event}';
        });
      }
    }, onError: (error) {
      developer.log('error: $error', name: 'Main');
    });

    NativeSsePlatform.instance2.startListenSSE(
      '...',
      {},
    ).listen((event) {
      developer.log('event2: $event', name: 'Main');
      if (event != null && event.toString().isNotEmpty == true) {
        setState(() {
          data = '${data}\n{$event}';
        });
      }
    }, onError: (error) {
      developer.log('error: $error', name: 'Main');
    });

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $data'),
        ),
      ),
    );
  }
}

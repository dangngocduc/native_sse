# native_sse

Demonstrates how to use the native_sse plugin.

## Getting Started

## How to use

```dart
  Future<void> initPlatformState() async {
    _nativeSsePlugin.startListenSSE(
      url: '....',
      headers: {
        'Authorization':
            'Bearer ...',
      },
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

    if (!mounted) return;
  }

```

import 'dart:async';


import 'package:web/web.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the FlutterHi plugin.
class FlutterWindowClosePluginWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'flutter_window_close',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = FlutterWindowClosePluginWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  FlutterWindowClosePluginWeb() {
    const EventStreamProvider<BeforeUnloadEvent>('beforeunload').forTarget(window).listen((Event unloadEvent) {
      if (_returnValue != null) {
          event.returnValue = _returnValue;
        }
    });
  }

  String? _returnValue;

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'setWebReturnValue':
        _returnValue = call.arguments;
        break;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'flutter_hi for web doesn\'t implement \'${call.method}\'',
        );
    }
  }
}

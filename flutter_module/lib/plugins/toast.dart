import 'dart:async';
import 'package:flutter/services.dart';

class Toast {
  static const MethodChannel _channel =
      const MethodChannel('com.jeremyliao.flutter.plugins/toast');

  static void showToast(String message) {
    _channel.invokeMethod("showToast", {"message": message});
  }
}

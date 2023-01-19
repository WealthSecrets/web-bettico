import 'package:flutter/material.dart';

class WidgetUtils {
  static void onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppBorderRadius {
  const AppBorderRadius._();

  static BorderRadius button = const BorderRadius.all(Radius.circular(6));
  static BorderRadius smallAll = const BorderRadius.all(Radius.circular(8));
  static BorderRadius smallTop = const BorderRadius.only(
    topRight: Radius.circular(8),
    topLeft: Radius.circular(8),
  );

  static BorderRadius smallBottom = const BorderRadius.only(
    topRight: Radius.circular(8),
    topLeft: Radius.circular(8),
  );

  static BorderRadius card = const BorderRadius.all(Radius.circular(10));

  static BorderRadius zero = BorderRadius.zero;

  static BorderRadius mediumAll = const BorderRadius.all(Radius.circular(16));

  static BorderRadius mediumTop = const BorderRadius.only(
    topRight: Radius.circular(16),
    topLeft: Radius.circular(16),
  );

  static BorderRadius mediumBottom = const BorderRadius.only(
    bottomRight: Radius.circular(16),
    bottomLeft: Radius.circular(16),
  );

  static BorderRadius largeAll = const BorderRadius.all(Radius.circular(32));

  static BorderRadius largeTop = const BorderRadius.only(
    topRight: Radius.circular(32),
    topLeft: Radius.circular(32),
  );

  static BorderRadius largeBottom = const BorderRadius.only(
    bottomRight: Radius.circular(32),
    bottomLeft: Radius.circular(32),
  );
}

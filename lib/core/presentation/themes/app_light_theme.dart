import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'themes.dart';

class AppLightTheme implements ThemeColor {
  static const Color _black = Color(0xFF212121);
  @override
  MaterialColor hint = HintColor.color;
  @override
  MaterialColor accent = PrimaryColor.accent;
  @override
  MaterialColor primary = PrimaryColor.color;

  @override
  Color success = const Color(0xFF0FC578);
  @override
  Color secondary = const Color(0xFFBEBF99);
  @override
  Color error = const Color(0xFFD20000);

  @override
  Color black = const Color(0xFF141619);

  @override
  Color background = Colors.white;
  @override
  Color background40 = const Color(0xFFF4F5F7);

  @override
  Color hintLight = const Color(0xFFf2059f);

  @override
  Color text = const Color(0xFF555F6D);

  @override
  Color darkenText = const Color(0xFF7E8B99);

  @override
  Color textInputBackground = const Color(0xFFFBFCFD);

  @override
  Color textInputText = const Color(0xFF272E35);

  @override
  Color textInputIconColor = const Color(0xFF9EA8B3);

  @override
  Color textDark = const Color(0xFF3d3d3d);

  @override
  Color icon = const Color(0xFF7E8B99);

  @override
  Color cardColor = const Color(0xFFF0F0F0);

  @override
  Color dividerColor = const Color(0xFFDDDFE2);

  @override
  Color grey = const Color(0xFF475B64);
  @override
  Color yellow = const Color(0xFFFCC019);
  @override
  Color blue = const Color(0xFF132DB0);
  @override
  Color pinColor = const Color(0xFFFBFCFD);
  //
  // E9ECEF
  @override
  Color inputBackgroundColor = const Color(0xFFFBFCFD);

  @override
  Color lightRed = const Color(0xFFFFDBDB);
  @override
  Color lightBlue = const Color(0xFFECF3FF);
  @override
  Color lightYellow = const Color(0xFFF9F3E4);
  @override
  Color lightGreen = const Color(0xFFE3FFEF);
  @override
  Color lightGrey = const Color(0xFFF5F5F5);
  @override
  Color faintGrey = const Color(0xFFEEF1F1);

  @override
  Color darkRed = const Color(0xFFD20000);
  @override
  Color darkBlue = const Color(0xFF004E92);
  @override
  Color darkYellow = const Color(0xFFAA7503);
  @override
  Color darkGreen = const Color(0xFF37CF76);

  @override
  Color overlay30 = _black.withOpacity(.3);
  @override
  Color overlay50 = _black.withOpacity(.5);
  @override
  Color overlay70 = _black.withOpacity(.7);

  @override
  Brightness brightness = Brightness.light;
  @override
  SystemUiOverlayStyle statusBar = SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
  @override
  Color shadowColor = HintColor.color.shade50;
}

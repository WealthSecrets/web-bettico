import 'package:flutter/widgets.dart';

class OptionArgument {
  OptionArgument({required this.icon, required this.title, required this.onPressed});
  final String title;
  final String icon;
  final VoidCallback onPressed;
}

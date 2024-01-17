import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class AppTag extends StatelessWidget {
  const AppTag({super.key, this.icon, required this.text});

  final String? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134,
      height: 35,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3F5),
        borderRadius: AppBorderRadius.largeAll,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Image.asset(icon!, color: context.colors.textInputText, height: 20, width: 20),
            const SizedBox(width: 5),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
              color: context.colors.textInputText,
            ),
          ),
        ],
      ),
    );
  }
}

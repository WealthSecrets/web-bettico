import 'package:betticos/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.hideMoreIcon = false,
  });

  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool hideMoreIcon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: AppPaddings.lV.add(AppPaddings.mV),
      ),
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          if (icon == null) const SizedBox.shrink() else Icon(icon, size: 22, color: context.colors.text),
          const AppSpacing(h: 26),
          Text(text, style: TextStyle(color: context.colors.textDark, fontSize: 14)),
          const Spacer(),
          if (!hideMoreIcon) Icon(CupertinoIcons.right_chevron, color: context.colors.hintLight),
        ],
      ),
    );
  }
}

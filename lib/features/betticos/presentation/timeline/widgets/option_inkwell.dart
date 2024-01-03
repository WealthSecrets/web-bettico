import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class OptionInkwell extends StatelessWidget {
  const OptionInkwell({super.key, required this.onTap, required this.iconData, required this.title});

  final VoidCallback onTap;
  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: AppPaddings.bodyH.add(AppPaddings.lV),
        child: Row(
          children: <Widget>[
            Icon(iconData, color: context.colors.textDark, size: 24),
            const AppSpacing(h: 16),
            Text(
              title,
              style: context.body2.copyWith(color: context.colors.textDark, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

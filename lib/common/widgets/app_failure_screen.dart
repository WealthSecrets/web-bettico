import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AppFailureScreen extends StatelessWidget {
  const AppFailureScreen(this.message, {super.key, this.onRetry, this.lightTheme = true});
  final String message;
  final VoidCallback? onRetry;
  final bool lightTheme;

  @override
  Widget build(BuildContext context) {
    return AppAnimatedColumn(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const AppSpacing(v: 10),
        Stack(
          children: <Widget>[
            Icon(Ionicons.information_outline, color: context.colors.darkRed, size: 40),
            Transform.translate(
              offset: const Offset(3, 3),
              child: Icon(Ionicons.information, color: context.colors.darkRed.withOpacity(.1), size: 40),
            ),
          ],
        ),
        const AppSpacing(v: 20),
        Padding(
          padding: AppPaddings.lA,
          child: Text(
            message,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: context.body2.copyWith(
              fontWeight: FontWeight.w300,
              color: lightTheme ? context.colors.textDark : Colors.white,
            ),
          ),
        ),
        const AppSpacing(v: 10),
        TextButton(
          onPressed: onRetry,
          style: TextButton.styleFrom(backgroundColor: context.colors.primary.shade100),
          child: Text(
            'Retry',
            style: context.caption.copyWith(fontWeight: FontWeight.w700, color: context.colors.primary),
          ),
        )
      ],
    );
  }
}

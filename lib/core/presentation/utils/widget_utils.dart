import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:flutter/material.dart';

class WidgetUtils {
  static void onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  static void showDeleteConnectionDialogue(
    BuildContext context, {
    String? title,
    Icon? icon,
    required Function() onPressed,
  }) {
    showAppModal<void>(
      context: context,
      alignment: Alignment.center,
      builder: (BuildContext context) {
        final bool _isSmallScreen = ResponsiveWidget.isSmallScreen(context);
        final double width = ResponsiveWidget.isSmallScreen(context)
            ? MediaQuery.of(context).size.width
            : 370;
        return Center(
          child: Container(
            width: width,
            height: _isSmallScreen ? 315 : 330,
            margin: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 16 : 0),
            child: AppOptionDialogueModal(
              modalContext: context,
              title: 'Disconnect Wallet',
              backgroundColor: context.colors.error,
              message:
                  'This will disconnect your wallet address from Bettico. Are you sure you want to disconnect wallet?',
              affirmButtonText: 'Disconnect'.toUpperCase(),
              onPressed: onPressed,
            ),
          ),
        );
      },
    );
  }
}

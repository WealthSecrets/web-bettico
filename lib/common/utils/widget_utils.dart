import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/presentation/login/widgets/unauth_login_container.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
        final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
        final double width = ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width : 370;
        return Center(
          child: Container(
            width: width,
            height: isSmallScreen ? 315 : 330,
            margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 0),
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

  static void showUnAuthorizedLoginContainer(
    BuildContext context, {
    String? title,
    Icon? icon,
  }) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    showAppModal<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: isSmallScreen ? double.infinity : 600,
            height: isSmallScreen ? 450 : 500,
            margin: AppPaddings.lH,
            child: ClipRRect(
              borderRadius: AppBorderRadius.largeAll,
              child: UnAuthLoginController(),
            ),
          ),
        );
      },
    );
  }

  static void showUnAuthorizedLoginModalBottomSheet(
    BuildContext context, {
    String? title,
    Icon? icon,
  }) {
    showMaterialModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.mediumTop),
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: AppBorderRadius.mediumTop,
          child: SizedBox(height: 450, child: UnAuthLoginController()),
        );
      },
    );
  }
}

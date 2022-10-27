import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '/core/presentation/presentation.dart';

class NewLiveScoreAppBar extends StatelessWidget {
  const NewLiveScoreAppBar({
    Key? key,
    this.title,
    this.subtitle,
    this.onMenuPressed,
    this.onPressed,
    required this.walletAddress,
    required this.onChanged,
    this.actions,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final String walletAddress;
  final Function()? onMenuPressed;
  final Function()? onPressed;
  final Function(String text) onChanged;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: BlurredBox(
        backgroundColor: context.colors.background.withOpacity(.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        title ?? 'LiveScore',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: context.colors.textDark,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle ?? 'All current live scores and updates',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: context.colors.textDark,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/images/betting.png',
                    color: Colors.black,
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () {
                    navigationController
                        .navigateTo(AppRoutes.p2pBettingHistory);
                  },
                ),
                if (actions != null) ...actions!
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: AppPaddings.homeH,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Ionicons.wallet_sharp,
                    size: 20,
                    color: walletAddress.isEmpty
                        ? context.colors.grey
                        : context.colors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    walletAddress.isEmpty
                        ? 'Wallet not connected.'
                        : walletAddress.replaceRange(
                            11,
                            walletAddress.length,
                            '*************',
                          ),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: context.colors.textDark,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onPressed,
                    child: Container(
                      padding: AppPaddings.mH.add(AppPaddings.sV),
                      decoration: BoxDecoration(
                        borderRadius: AppBorderRadius.largeAll,
                        color: walletAddress.isEmpty
                            ? context.colors.grey.withOpacity(.3)
                            : context.colors.success.withOpacity(.3),
                        border: Border.all(
                          color: walletAddress.isEmpty
                              ? context.colors.grey
                              : context.colors.success,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        walletAddress.isEmpty ? 'CONNECT' : 'CONNECTED',
                        style: context.overline.copyWith(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: walletAddress.isEmpty
                              ? context.colors.text
                              : context.colors.success,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const AppSpacing(v: 20),
          ],
        ),
      ),
    );
  }
}

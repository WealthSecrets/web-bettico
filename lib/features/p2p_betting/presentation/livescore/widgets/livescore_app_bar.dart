import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/livescore_search_delegate.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/presentation/presentation.dart';
import '/core/presentation/widgets/sliver_app_bar_deleagate.dart';

class LiveScoreAppBar extends StatelessWidget {
  const LiveScoreAppBar({
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
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppBarDelegate2(
        maxHeight: kToolbarHeight.h + 50.h + MediaQuery.of(context).padding.top,
        minHeight: kToolbarHeight.h + 50.h + MediaQuery.of(context).padding.top,
        child: BlurredBox(
          backgroundColor: context.colors.background.withOpacity(.9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (ResponsiveWidget.isSmallScreen(context))
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: onMenuPressed,
                    ),
                  if (!ResponsiveWidget.isSmallScreen(context))
                    IconButton(
                      icon: const Icon(
                        Ionicons.chevron_back,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
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
                      AssetImages.betting,
                      color: Colors.black,
                      height: 24,
                      width: 24,
                    ),
                    onPressed: () {
                      Get.toNamed<void>(P2PBettingHistoryScreen.route);
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      showSearch<String>(context: context, delegate: LivescoreSearchDelegate());
                    },
                    icon: Icon(
                      Icons.search,
                      color: context.colors.black,
                    ),
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
                      color: walletAddress.isEmpty ? context.colors.grey : context.colors.primary,
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
                            color: walletAddress.isEmpty ? context.colors.grey : context.colors.success,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          walletAddress.isEmpty ? 'CONNECT' : 'CONNECTED',
                          style: context.overline.copyWith(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: walletAddress.isEmpty ? context.colors.text : context.colors.success,
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
      ),
    );
  }
}

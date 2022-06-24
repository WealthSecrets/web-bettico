import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/livescore_search_delegate.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:ionicons/ionicons.dart';

import '/core/presentation/presentation.dart';
import '/core/presentation/widgets/sliver_app_bar_deleagate.dart';
// import 'app_selectable_tile.dart';

class LiveScoreAppBar extends StatelessWidget {
  const LiveScoreAppBar({
    Key? key,
    this.title,
    this.subtitle,
    this.onPressed,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppBarDelegate2(
        maxHeight: 70 + MediaQuery.of(context).padding.top,
        minHeight: 70 + MediaQuery.of(context).padding.top,
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
                      onPressed: onPressed,
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
                      'assets/images/betting.png',
                      color: Colors.black,
                      height: 24,
                      width: 24,
                    ),
                    onPressed: () {
                      Get.toNamed<void>(AppRoutes.p2pBettingHistory);
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      showSearch<String>(
                          context: context,
                          delegate: LivescoreSearchDelegate());
                    },
                    icon: Icon(
                      Icons.search,
                      color: context.colors.black,
                    ),
                  ),
                ],
              ),
              // const AppSpacing(v: 16),
              // SizedBox(
              //   height: 50,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (
              //       BuildContext context,
              //       int index,
              //     ) {
              //       if (index == 0) {
              //         return const AppSpacing(h: 16);
              //       }
              //       return Padding(
              //         padding: const EdgeInsets.only(right: 16.0),
              //         child: AppSelectableTile(
              //           padding: AppPaddings.mA,
              //           onPressed: () {},
              //           width: 180.w,
              //           icon: SizedBox(
              //             width: 30,
              //             height: 30,
              //             child: SvgPicture.asset(
              //               'assets/svgs/premier-league.svg',
              //             ),
              //           ),
              //           selected: index == 1,
              //           title: 'Premier League',
              //           textOverflow: TextOverflow.ellipsis,
              //         ),
              //       );
              //     },
              //     itemCount: 4,
              //   ),
              // ),
              const AppSpacing(v: 20),
            ],
          ),
        ),
      ),
    );
  }
}

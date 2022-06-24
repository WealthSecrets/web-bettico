import 'package:betticos/core/presentation/widgets/sliver_app_bar_deleagate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';

class P2PBettingFilterBar extends StatelessWidget {
  const P2PBettingFilterBar({
    Key? key,
  }) : super(key: key);

  // fake data
  final List<String> filter = const <String>['wins', 'losts'];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: AppPaddings.homeH,
      sliver: SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate2(
          maxHeight: kToolbarHeight.h + MediaQuery.of(context).padding.top,
          minHeight: kToolbarHeight.h + MediaQuery.of(context).padding.top,
          child: BlurredBox(
            backgroundColor: context.colors.background.withOpacity(.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // const Spacer(),
                Row(
                  children: <Widget>[
                    Text(
                      'My Bets',
                      style: context.body1.copyWith(
                        color: context.colors.textDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    AppSelectField<String>(
                      onChanged: (String value) {},
                      options: filter,
                      value: filter[0].toUpperCase(),
                      customChildBuilder:
                          (BuildContext context, String? item) => Row(
                        children: <Widget>[
                          const Icon(
                            Ionicons.funnel_outline,
                            size: 18,
                          ),
                          Container(
                            margin: AppPaddings.sH,
                            width: 1,
                            height: 20,
                            color: context.colors.text,
                          ),
                          if (item == null)
                            Text(
                              'Select',
                              style: context.caption.copyWith(
                                fontWeight: FontWeight.w700,
                                color: context.colors.text,
                              ),
                            )
                          else
                            Text(
                              item,
                              style: context.caption.copyWith(
                                fontWeight: FontWeight.w700,
                                color: context.colors.text,
                              ),
                            ),
                          const AppSpacing(h: 5),
                          Icon(
                            CupertinoIcons.chevron_down,
                            size: AppFontSizes.caption,
                          )
                        ],
                      ),
                      titleBuilder: (_, String item) => item.toUpperCase(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

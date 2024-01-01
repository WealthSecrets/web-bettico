import 'package:betticos/features/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';

class P2PBettingFilterBar extends StatelessWidget {
  P2PBettingFilterBar({super.key});

  final P2PBetController _p2pBetController = Get.find<P2PBetController>();

  final List<String> options = const <String>['wins', 'losts', 'awaiting', 'ongoing', 'completed'];

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
                      style: TextStyle(
                        color: context.colors.textDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    AppSelectField<String>(
                      onChanged: (String value) => _p2pBetController.changeFilterStatus(value.toLowerCase()),
                      options: options,
                      value: options[0].toUpperCase(),
                      customChildBuilder: (BuildContext context, String? item) => Row(
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
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: context.colors.text,
                                fontSize: 12,
                              ),
                            )
                          else
                            Text(
                              item.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: context.colors.text,
                                fontSize: 12,
                              ),
                            ),
                          const AppSpacing(h: 5),
                          const Icon(
                            CupertinoIcons.chevron_down,
                            size: 12,
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

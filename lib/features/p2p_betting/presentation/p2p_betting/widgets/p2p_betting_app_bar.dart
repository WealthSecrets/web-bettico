import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class P2PBettingAppBar extends StatelessWidget {
  const P2PBettingAppBar({super.key, this.title, this.subtitle});

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.transparent,
      leading: const Align(
        alignment: Alignment(0, -.8),
        child: AppBackButton(),
      ),
      toolbarHeight: 50,
      flexibleSpace: BlurredBox(
        backgroundColor: context.colors.background.withOpacity(.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              title ?? 'Bet Space',
              textScaleFactor: 1.0,
              style: TextStyle(
                color: context.colors.textDark,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle ?? 'Your ongoing and completed P2P bets',
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
    );
  }
}

import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/selectable_button.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'account_reached_screen.dart';

class AccountInsightsScreen extends StatelessWidget {
  const AccountInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Insights',
          style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppAnimatedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Align(
            //   child: Text(
            //     'Overview',
            //     style: context.h6.copyWith(fontWeight: FontWeight.bold, color: context.colors.textDark),
            //   ),
            // ),
            // const AppSpacing(v: 8),
            // Align(
            //   child: Text(
            //     'You gained 14 more followers compared to Apr 29 - May 28',
            //     style: context.caption.copyWith(fontWeight: FontWeight.bold, color: context.colors.text),
            //   ),
            // ),
            // const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SelectableButton(
                  text: 'Awaiting',
                  selected: true,
                  onPressed: () {},
                ),
                SelectableButton(
                  text: 'Ongoing',
                  selected: false,
                  onPressed: () {},
                ),
                SelectableButton(
                  text: 'Completed',
                  selected: false,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            const AccountReachedScreen(),
          ],
        ),
      ),
    );
  }
}

class _ClickableTitleText extends StatelessWidget {
  const _ClickableTitleText({required this.title, required this.count});
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const <BoxShadow>[BoxShadow(blurRadius: 5, color: Colors.black12, offset: Offset(0, 1))],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: context.colors.textDark),
          ),
          const Spacer(),
          Text(
            count,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: context.colors.text),
          ),
          const SizedBox(width: 5),
          Icon(Ionicons.chevron_forward_sharp, color: context.colors.text, size: 24)
        ],
      ),
    );
  }
}

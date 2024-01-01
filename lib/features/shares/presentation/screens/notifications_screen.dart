import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class NotificationsScreenRouteArgument {
  const NotificationsScreenRouteArgument({required this.contributions});

  final dynamic contributions;
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key, required this.contributions});

  final dynamic contributions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contributions',
          style: context.caption.copyWith(color: context.colors.textDark),
        ),
        actions: <Widget>[
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Avatar(
              size: 30,
              margin: AppPaddings.mH,
              imageUrl:
                  'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (BuildContext context, int index) => _NotificationItem(contribution: contributions[index]),
        itemCount: contributions.length,
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({required this.contribution});

  final dynamic contribution;

  @override
  Widget build(BuildContext context) {
    final double amount = int.parse('${contribution[3]}') / weiMultiplier;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${contribution[2]}',
              style: context.caption.copyWith(
                color: context.colors.textDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '22/10/23',
              style: context.caption.copyWith(color: context.colors.text),
            ),
          ],
        ),
        const AppSpacing(v: 5),
        Text(
          '@minakay contributed ${amount.toStringAsFixed(6)} ETH.',
          style: context.overline.copyWith(color: context.colors.textDark),
        ),
        const AppSpacing(v: 5),
        Divider(color: context.colors.faintGrey)
      ],
    );
  }
}

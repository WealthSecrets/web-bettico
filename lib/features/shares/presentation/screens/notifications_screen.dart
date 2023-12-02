import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
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
        itemBuilder: (BuildContext context, int index) => const _NotificationItem(),
        itemCount: 100,
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'New Trade',
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
          '@minakay sold one of your shares for 0.000123 Eth',
          style: context.overline.copyWith(color: context.colors.textDark),
        ),
        const AppSpacing(v: 5),
        Divider(color: context.colors.faintGrey)
      ],
    );
  }
}

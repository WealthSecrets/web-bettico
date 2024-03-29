import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class TimeCard extends StatelessWidget {
  const TimeCard({super.key, required this.dateTime, this.showOnlyDate, this.showOnlyTime});

  final DateTime dateTime;
  final bool? showOnlyDate;
  final bool? showOnlyTime;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(borderRadius: AppBorderRadius.largeAll, color: context.colors.grey.withOpacity(.05)),
        child: Row(
          children: <Widget>[
            if (showOnlyTime ?? false) Padding(padding: AppPaddings.sH, child: const Icon(Ionicons.time, size: 18)),
            if (showOnlyDate ?? false)
              Text(
                DateFormat('d MMM, yy').format(dateTime),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: context.colors.text,
                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 10 : 12,
                ),
              ),
            if (!(showOnlyDate ?? false) && !(showOnlyTime ?? false))
              Text(
                DateFormat('d MMM, yy  |  hh:mm aaa').format(dateTime),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: context.colors.text,
                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 10 : 12,
                ),
              ),
            if (showOnlyTime ?? false)
              Text(
                DateFormat('hh:mm aaa').format(dateTime),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: context.colors.text,
                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 10 : 12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

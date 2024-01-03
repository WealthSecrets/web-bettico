import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

enum SalesStatus { notstarted, live, ended }

class SaleStatusChip extends StatelessWidget {
  const SaleStatusChip({super.key, required this.status});

  final SalesStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveWidget.isSmallScreen(context)
          ? const EdgeInsets.symmetric(vertical: 4).add(const EdgeInsets.symmetric(horizontal: 8))
          : const EdgeInsets.symmetric(vertical: 4).add(const EdgeInsets.symmetric(horizontal: 16)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: status == SalesStatus.live
            ? context.colors.success
            : status == SalesStatus.ended
                ? context.colors.error
                : context.colors.primary,
      ),
      child: Center(
        child: Text(
          status.value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: ResponsiveWidget.isSmallScreen(context) ? FontWeight.bold : FontWeight.normal,
            fontSize: ResponsiveWidget.isSmallScreen(context) ? 10 : 12,
          ),
        ),
      ),
    );
  }
}

extension SalesStatusX on SalesStatus {
  String get value {
    switch (this) {
      case SalesStatus.notstarted:
        return 'Not Started';
      case SalesStatus.live:
        return 'Live';
      case SalesStatus.ended:
        return 'Ended';
    }
  }
}

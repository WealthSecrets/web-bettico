import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class VerificationBottomSheet extends StatelessWidget {
  const VerificationBottomSheet({super.key, required this.isLoggedInUser});

  final bool isLoggedInUser;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: AppPaddings.lA.add(AppPaddings.mA),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Verified Account',
              style: context.h5.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.1, color: Colors.black),
            ),
            const SizedBox(height: 16),
            _IconRow(
              icon: AppAssetIcons.verified,
              text: 'This account is a verified creator account on level 1.',
            ),
            const SizedBox(height: 16),
            _IconRow(
              icon: AppAssetIcons.calendarDates,
              text: 'Verified since August 2023.',
            ),
            const SizedBox(height: 32),
            if (!isLoggedInUser) ...<Widget>[
              AppButton(
                onPressed: () {},
                child: Text(
                  'Verify your own account',
                  style: context.body1.copyWith(letterSpacing: 0.2, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
            ],
            ProfileButton(
              onPressed: () {},
              borderColor: context.colors.primary,
              height: 56,
              width: double.infinity,
              child: Text(
                'Cancel',
                style: context.body1.copyWith(letterSpacing: 0.2, color: context.colors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconRow extends StatelessWidget {
  const _IconRow({required this.icon, required this.text});

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 311.09,
      child: Row(
        children: <Widget>[
          Image.asset(icon, height: 20, width: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: context.sub2
                  .copyWith(color: const Color(0xFF4A545E), fontWeight: FontWeight.w300, letterSpacing: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}

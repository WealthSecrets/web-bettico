import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class LevelCard extends StatelessWidget {
  const LevelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      margin: AppPaddings.lB,
      decoration: BoxDecoration(
        color: context.colors.textInputBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(AppAssetIcons.tick, height: 20, width: 20),
            const SizedBox(width: 16),
            SizedBox(
              width: 258.03,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Verified',
                    style: context.body2
                        .copyWith(fontWeight: FontWeight.w600, color: const Color(0xFF7B39FE), letterSpacing: 0.2),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'This is the base level verification, users who have this have been on xviral for a while and are notable for cearll levels of publicity',
                    style: context.overline
                        .copyWith(letterSpacing: 0.2, fontWeight: FontWeight.w400, color: const Color(0xFF374B58)),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 38,
                    width: double.infinity,
                    padding: AppPaddings.lH,
                    decoration: BoxDecoration(color: const Color(0xFFF6F2FF), borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'How to upgrade to this level?',
                          style: context.overline.copyWith(
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF374B58),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        Image.asset(AppAssetIcons.question, height: 11, width: 11, color: const Color(0xFF374B58))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

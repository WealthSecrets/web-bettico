import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/presentation/timeline/widgets/timeline_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx/ads_controller.dart';
import '../widgets/popular_category_section.dart';
import '../widgets/step_controls.dart';

class AdsPreviewStep extends StatelessWidget {
  AdsPreviewStep({super.key});

  final AdsController controller = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () => Column(
          children: <Widget>[
            TimelineCard(post: controller.post.value),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                controller.isSpecialAdCategory.value = !controller.isSpecialAdCategory.value;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Special Ad category',
                    textAlign: TextAlign.left,
                    style: context.body2.copyWith(color: context.colors.textDark, fontWeight: FontWeight.w400),
                  ),
                  IgnorePointer(
                    child: AppCheckBox(
                      checkBoxMargin: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(2),
                      height: 24,
                      value: controller.isSpecialAdCategory.value,
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
            ),
            if (!controller.isSpecialAdCategory.value) ...<Widget>[
              const SizedBox(height: 5),
              Text(
                'If special Ad category is selected we will show your Ads to certain group of people.',
                style: context.caption.copyWith(
                  color: context.colors.text,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
            if (controller.isSpecialAdCategory.value) ...<Widget>[
              const SizedBox(height: 8),
              PopularCategorySection(),
            ],
            const Spacer(),
            StepControls(),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

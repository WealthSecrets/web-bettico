import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/advert/data/models/advert_model.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdsPreviewStep extends StatelessWidget {
  AdsPreviewStep({super.key});

  final AdsController controller = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () => Column(
          children: <Widget>[
            TimelineCard(post: controller.post.value, hideOptions: true, hideButtons: true, sponsored: true),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select your goal.',
                style: context.caption.copyWith(
                  color: context.colors.black,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: Target.values
                    .map(
                      (Target target) => AppConstrainedButton(
                        text: StringUtils.capitalizeFirst(target.name),
                        onPressed: () => controller.target.value = target,
                        constraints: const BoxConstraints(maxHeight: 40, minWidth: 80),
                        color: context.colors.primary,
                        textColor: Colors.white,
                        selected: controller.target.value == target,
                      ),
                    )
                    .toList(),
              ),
            ),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'If special Ad category is selected we will show your Ads to certain group of people.',
                  style: context.caption.copyWith(
                    color: context.colors.text,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
            if (controller.isSpecialAdCategory.value) ...<Widget>[
              const SizedBox(height: 8),
              PopularCategorySection(),
            ],
            const SizedBox(height: 56),
            StepControls(),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

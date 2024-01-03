import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/advert/presentation/getx/ads_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/special_category_type.dart';
import 'category_widget.dart';

class PopularCategorySection extends StatelessWidget {
  PopularCategorySection({super.key});

  final AdsController controller = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: SpecialCategoryType.values
              .map(
                (SpecialCategoryType type) => type.displayName.isNotEmpty
                    ? Obx(
                        () => CategoryWidget(
                          category: type.displayName,
                          isSelected: controller.category.value == type,
                          onPressed: () => controller.category.value = type,
                        ),
                      )
                    : const SizedBox.shrink(),
              )
              .toList(),
        ),
        const AppSpacing(v: 8),
        Obx(
          () => Text(
            controller.category.value.info,
            style: context.caption.copyWith(color: Colors.black),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}

extension SpecialCateoryTypex on SpecialCategoryType {
  String get info {
    switch (this) {
      case SpecialCategoryType.credit:
        return 'Ads for credit card offers, auto loans, long-term financing or other related opportunities.';
      case SpecialCategoryType.employment:
        return 'Ads for job offers, internships, professional certification programs or other related opportunities.';
      case SpecialCategoryType.housing:
        return 'Ads for real estate listings, homeowners insurance, mortgage loands or other related opportunities.';
      case SpecialCategoryType.socialIssues:
        return 'Ads about social issues such as the economy or civiy and social rights.';
      case SpecialCategoryType.election:
        return 'Ads for elections such as national election, assembly, Member of parliament eelctions.';
      case SpecialCategoryType.politics:
        return 'Ads about politics, topics related to politics.';
      case SpecialCategoryType.unknown:
        return '';
    }
  }
}

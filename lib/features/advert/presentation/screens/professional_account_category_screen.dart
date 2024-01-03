import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfessionalAccountCategoryScreen extends GetWidget<ProfessionalController> {
  const ProfessionalAccountCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPaddings.lH,
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 40),
              Text(
                'What best describes you?',
                style: context.h6.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 24),
              Text(
                'Categories help people find accounts like yours. You can change this at any time',
                style: context.sub2.copyWith(color: context.colors.text),
              ),
              const SizedBox(height: 24),
              _CategorySection(),
              const Spacer(),
              AppButton(
                onPressed: () => navigationController.navigateTo(AppRoutes.businessType),
                borderRadius: AppBorderRadius.largeAll,
                backgroundColor: context.colors.primary,
                enabled: controller.isBusinessCategoryValid,
                child: Text(
                  'NEXT',
                  style: context.sub2.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  _CategorySection();

  final ProfessionalController controller = Get.find<ProfessionalController>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 16,
      children: BusinessCategoryType.values
          .map(
            (BusinessCategoryType type) => type.displayName.isNotEmpty
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
    );
  }
}

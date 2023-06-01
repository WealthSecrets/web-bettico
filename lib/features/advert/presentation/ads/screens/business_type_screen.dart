import 'package:betticos/features/advert/presentation/ads/getx/professional_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '../../../../../core/presentation/helpers/responsiveness.dart';

class BusinessTypeScreen extends GetWidget<ProfessionalController> {
  const BusinessTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: context.colors.background,
        body: AppLoadingBox(
          loading: controller.isUpdatingBusinessType.value,
          child: Center(
            child: SizedBox(
              width: ResponsiveWidget.isSmallScreen(context) ? double.infinity : 450,
              child: SingleChildScrollView(
                padding: AppPaddings.bodyH,
                child: AppAnimatedColumn(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Are you a creator?',
                      style: context.h6.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Based on the category you selected, you may be a creator. You change this anytime.',
                      style: context.sub2.copyWith(color: context.colors.text),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _BuildAccountTypeCard(
                            onTap: (BusinessType value) => controller.businessType(value),
                            type: BusinessType.creator,
                            selected: controller.businessType.value == BusinessType.creator,
                          ),
                        ),
                        const AppSpacing(h: 12),
                        Expanded(
                          child: _BuildAccountTypeCard(
                            onTap: (BusinessType value) => controller.businessType(value),
                            type: BusinessType.business,
                            selected: controller.businessType.value == BusinessType.business,
                          ),
                        ),
                      ],
                    ),
                    const AppSpacing(v: 49),
                    Container(
                      decoration: BoxDecoration(
                        color: context.colors.primary.shade50,
                        borderRadius: AppBorderRadius.smallAll,
                      ),
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            controller.businessType.value == BusinessType.creator
                                ? 'Creator Account'
                                : 'Business Account',
                            style: TextStyle(fontWeight: FontWeight.w700, color: context.colors.primary, fontSize: 12),
                          ),
                          const AppSpacing(v: 10),
                          Text(
                            controller.businessType.value == BusinessType.business
                                ? 'Best for public figures, content producers, artists, and influencers.'
                                : 'Best for retailers, local businesses, brands, organizations and service providers.',
                            style: TextStyle(color: context.colors.black, fontWeight: FontWeight.w600, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    const AppSpacing(v: 100),
                    AppButton(
                      borderRadius: AppBorderRadius.largeAll,
                      backgroundColor: context.colors.primary,
                      onPressed: () {},
                      child: Text(
                        'next'.tr.toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    const AppSpacing(v: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildAccountTypeCard extends StatelessWidget {
  const _BuildAccountTypeCard({required this.selected, required this.type, required this.onTap});

  final bool selected;
  final BusinessType type;
  final Function(BusinessType) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(type);
      },
      child: ClipRRect(
        borderRadius: AppBorderRadius.smallAll,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected ? context.colors.primary : Colors.white,
            borderRadius: AppBorderRadius.smallAll,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 6.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 186.h,
                child: Padding(
                  padding: AppPaddings.mH.add(AppPaddings.lV.add(AppPaddings.mV)),
                  child: AppAnimatedColumn(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        type == BusinessType.creator ? Ionicons.person : Ionicons.storefront_sharp,
                        color: selected ? Colors.white : context.colors.hintLight,
                        size: 20,
                      ),
                      const AppSpacing(v: 16),
                      Text(
                        type == BusinessType.creator ? 'Creator Account' : 'Business Account',
                        style: TextStyle(
                          color: selected ? Colors.white : context.colors.text,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 700),
                  reverseDuration: const Duration(milliseconds: 400),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final Animation<double> scale = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
                    return ScaleTransition(
                      scale: scale,
                      child: child,
                    );
                  },
                  switchInCurve: Curves.elasticOut,
                  switchOutCurve: Curves.elasticInOut.flipped,
                  child: !selected
                      ? const SizedBox()
                      : const Icon(
                          CupertinoIcons.checkmark_square_fill,
                          size: 27,
                          color: Colors.white,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

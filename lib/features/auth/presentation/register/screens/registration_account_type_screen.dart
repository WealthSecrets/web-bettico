import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '../../../../../core/presentation/helpers/responsiveness.dart';
import '../../../data/models/user/user.dart';

class RegistrationAccountTypeScreen extends GetWidget<RegisterController> {
  const RegistrationAccountTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: context.colors.background,
        body: SafeArea(
          child: AppLoadingBox(
            loading: controller.isUpdatingUserRole.value,
            child: Center(
              child: SizedBox(
                width: ResponsiveWidget.isSmallScreen(context)
                    ? double.infinity
                    : 450,
                child: SingleChildScrollView(
                  padding: AppPaddings.bodyH,
                  child: AppAnimatedColumn(
                    direction: Axis.horizontal,
                    duration: const Duration(milliseconds: 1000),
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'account_type'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const AppSpacing(v: 47),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _BuildAccountTypeCard(
                              onTap: controller.onAccountTypeSelected,
                              type: AccountType.personal,
                              selected: controller.accountType.value ==
                                  AccountType.personal,
                            ),
                          ),
                          const AppSpacing(h: 12),
                          Expanded(
                            child: _BuildAccountTypeCard(
                              onTap: controller.onAccountTypeSelected,
                              type: AccountType.oddster,
                              selected: controller.accountType.value ==
                                  AccountType.oddster,
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
                              controller.accountType.value ==
                                      AccountType.personal
                                  ? 'personal_account'.tr
                                  : 'oddster_account'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: context.colors.primary,
                                fontSize: 12,
                              ),
                            ),
                            const AppSpacing(v: 10),
                            Text(
                              controller.accountType.value ==
                                      AccountType.personal
                                  ? 'personal_account_info'.tr
                                  : 'oddster_account_info'.tr,
                              style: TextStyle(
                                color: context.colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const AppSpacing(v: 100),
                      AppButton(
                        borderRadius: AppBorderRadius.largeAll,
                        backgroundColor: context.colors.primary,
                        onPressed: () => registerController.updateRole(context),
                        child: Text(
                          'next'.tr.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
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
      ),
    );
  }
}

class _BuildAccountTypeCard extends StatelessWidget {
  const _BuildAccountTypeCard({
    Key? key,
    required this.selected,
    required this.type,
    required this.onTap,
  }) : super(key: key);

  final bool selected;
  final AccountType type;
  final Function(AccountType) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(type);
      },
      child: ClipRRect(
        borderRadius: AppBorderRadius.smallAll,
        child: Container(
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
                  padding:
                      AppPaddings.mH.add(AppPaddings.lV.add(AppPaddings.mV)),
                  child: AppAnimatedColumn(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        type == AccountType.personal
                            ? Ionicons.person
                            : Ionicons.football_outline,
                        color:
                            selected ? Colors.white : context.colors.hintLight,
                        size: 20,
                      ),
                      const AppSpacing(v: 16),
                      Text(
                        type == AccountType.personal
                            ? 'personal_account'.tr
                            : 'oddster_account'.tr,
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
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    final Animation<double> scale =
                        Tween<double>(begin: 0.0, end: 1.0).animate(animation);
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

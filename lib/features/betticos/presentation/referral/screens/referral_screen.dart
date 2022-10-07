// ignore_for_file: must_be_immutable, use_key_in_widget_constructors
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';

import '/core/core.dart';
import '/features/betticos/presentation/referral/getx/referral_controller.dart';

class ReferralScreen extends KFDrawerContent {
  ReferralScreen({Key? key}) : super(key: key);

  static const String route = '/referral';
  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final ReferralController referralController = Get.find<ReferralController>();

  @override
  void initState() {
    WidgetUtils.onWidgetDidBuild(() {
      referralController.getTheReferralCode(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'refer_earn'.tr,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        leading: ResponsiveWidget.isSmallScreen(context)
            ? IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: widget.onMenuPressed,
              )
            : null,
      ),
      body: Obx(
        () => AppLoadingBox(
          loading: referralController.isLoading.value || referralController.isReferringUser.value,
          child: Padding(
            padding: AppPaddings.homeH,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SvgPicture.asset(
                    AssetSVGs.referral.path,
                    height: 200,
                  ),
                  const AppSpacing(v: 16),
                  Text(
                    'going_further'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const AppSpacing(v: 30),
                  Text(
                    'refer_code'.tr.toUpperCase(),
                    style: TextStyle(
                      color: context.colors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const AppSpacing(v: 8),
                  Container(
                    padding: AppPaddings.lH,
                    width: MediaQuery.of(context).size.width,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: context.colors.primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          referralController.referralCode.value.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(
                              ClipboardData(
                                text:
                                    '${'enjoy_exclusive_1'.tr}\n\n${'refer_code'.tr}: ${referralController.referralCode.value.toUpperCase()}.\n\n${'enjoy_exclusive_2'.tr}',
                              ),
                            );
                            await AppSnacks.show(
                              context,
                              message: 'copied'.tr,
                              backgroundColor: context.colors.success,
                              leadingIcon: const Icon(
                                Ionicons.checkmark_sharp,
                                size: 20,
                                color: Colors.white,
                              ),
                            );
                          },
                          child: Container(
                            height: 30,
                            padding: AppPaddings.lH.add(AppPaddings.mV),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'copy'.tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const AppSpacing(v: 30),
                  AppTextInput(
                    hintText: 'email'.tr.toUpperCase(),
                    backgroundColor: context.colors.primary.shade100,
                    lableStyle: TextStyle(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                    errorStyle: TextStyle(
                      color: context.colors.error,
                      fontSize: 12,
                    ),
                    validator: referralController.validateEmail,
                    onChanged: referralController.onEmailInputChanged,
                  ),
                  const AppSpacing(v: 100),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: AppButton(
                          enabled: referralController.formIsValid,
                          padding: EdgeInsets.zero,
                          borderRadius: AppBorderRadius.largeAll,
                          backgroundColor: context.colors.primary,
                          onPressed: () {
                            referralController.referralUserByEmail(context);
                          },
                          child: Text(
                            'refer_by_email'.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const AppSpacing(h: 10),
                      SizedBox(
                        width: 56,
                        child: AppButton(
                          padding: EdgeInsets.zero,
                          backgroundColor: context.colors.primary,
                          borderRadius: AppBorderRadius.largeAll,
                          onPressed: () {
                            Share.share(
                              '${'enjoy_exclusive_1'.tr}\n\n${'refer_code'.tr}: ${referralController.referralCode.value.toUpperCase()}.\n\n${'enjoy_exclusive_2'.tr}',
                              subject: 'Refer To User',
                            );
                          },
                          child: const Icon(
                            Ionicons.share_social_sharp,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

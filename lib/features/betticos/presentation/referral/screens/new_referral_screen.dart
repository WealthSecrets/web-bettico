import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../getx/referral_controller.dart';

class NewReferralScreen extends StatefulWidget {
  const NewReferralScreen({super.key});

  @override
  State<NewReferralScreen> createState() => _NewReferralScreenState();
}

class _NewReferralScreenState extends State<NewReferralScreen> {
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
      body: Obx(
        () {
          return AppLoadingBox(
            loading: referralController.isLoading.value || referralController.isReferringUser.value,
            child: Padding(
              padding: AppPaddings.lA,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const AppSpacing(v: 56),
                  const Align(child: _StackImage()),
                  const AppSpacing(v: 48),
                  Text(
                    'invite your friends'.toUpperCase(),
                    style: context.body1.copyWith(color: context.colors.textInputIconColor),
                  ),
                  const AppSpacing(v: 16),
                  Text(
                    'XViral Referral',
                    style: context.h4
                        .copyWith(color: context.colors.textInputText, fontWeight: FontWeight.w600, letterSpacing: 0.1),
                  ),
                  const AppSpacing(v: 16),
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {},
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: context.body2,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'By referring a friend, I confirm that I have their consent to receive the referral, and I accept the',
                              style: TextStyle(color: context.colors.text, fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: 'Terms & Conditions.',
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              style:
                                  TextStyle(color: context.colors.primary, fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    onPressed: () => Share.share(
                      '${'enjoy_exclusive_1'.tr}\n\n${'refer_code'.tr}: ${referralController.referralCode.value.toUpperCase()}.\n\n${'enjoy_exclusive_2'.tr}',
                      subject: 'Refer To User',
                    ),
                    child: const Text(
                      'Share your invite link',
                      style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StackImage extends StatelessWidget {
  const _StackImage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(AssetImages.eclipse, height: 175.91, width: 175.91),
        Positioned(
          left: 0,
          right: 0,
          bottom: 18.57,
          child: Image.asset(AssetImages.envelope, height: 123.56, width: 127.03),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -10,
          child: Image.asset(AssetImages.bar, height: 28.57, width: 151.04),
        ),
      ],
    );
  }
}

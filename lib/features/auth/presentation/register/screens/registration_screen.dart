import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

import '/core/core.dart';
import '../../../../../core/presentation/helpers/responsiveness.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  final RegisterController registerController = Get.find<RegisterController>();

  // get type of verification
  final String? params = Get.parameters['type'];

  @override
  Widget build(BuildContext context) {
    final bool isWalletConnect = params != null && params!.toLowerCase() == 'walletconnect';
    return Obx(
      () => AppLoadingBox(
        loading: registerController.isRegisteringUser.value || registerController.isCreatingOkxAccount.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Transform.translate(
              offset: const Offset(10, 0),
              child: const AppBackButton(),
            ),
          ),
          backgroundColor: context.colors.background,
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: ResponsiveWidget.isSmallScreen(context) ? double.infinity : 450,
                child: SingleChildScrollView(
                  padding: AppPaddings.lH,
                  child: AppAnimatedColumn(
                    direction: Axis.horizontal,
                    duration: const Duration(milliseconds: 1000),
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          isWalletConnect ? 'Sign up with WalletConnect' : 'create_account'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: context.colors.hintLight,
                          ),
                        ),
                      ),
                      const AppSpacing(v: 30),
                      Text(
                        isWalletConnect ? 'Create a password for your signup and click \'Next\'' : 'signup_info'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          height: 1.22,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const AppSpacing(v: 30),
                      if (!isWalletConnect)
                        AppTextInput(
                          labelText: 'email_address'.tr.toUpperCase(),
                          prefixIcon: Icon(
                            Ionicons.mail_outline,
                            color: context.colors.hintLight,
                          ),
                          backgroundColor: context.colors.primary.shade100,
                          lableStyle: TextStyle(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                          validator: registerController.validateEmail,
                          onChanged: registerController.onEmailInputChanged,
                        ),
                      if (!isWalletConnect) const AppSpacing(v: 8),
                      AppTextInput(
                        obscureText: true,
                        labelText: 'password'.tr.toUpperCase(),
                        showObscureTextToggle: true,
                        backgroundColor: context.colors.primary.shade100,
                        prefixIcon: Icon(
                          Ionicons.lock_closed_outline,
                          color: context.colors.hintLight,
                        ),
                        lableStyle: TextStyle(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                        errorStyle: TextStyle(
                          color: context.colors.error,
                          fontSize: 12,
                        ),
                        validator: registerController.validatePassword,
                        onChanged: registerController.onPasswordInputChanged,
                      ),
                      const AppSpacing(v: 8),
                      AppTextInput(
                        obscureText: true,
                        labelText: 'confirm_pass'.tr.toUpperCase(),
                        showObscureTextToggle: true,
                        backgroundColor: context.colors.primary.shade100,
                        prefixIcon: Icon(
                          Ionicons.lock_closed_outline,
                          color: context.colors.hintLight,
                        ),
                        lableStyle: TextStyle(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                        errorStyle: TextStyle(
                          color: context.colors.error,
                          fontSize: 12,
                        ),
                        validator: registerController.validateConfrimPassword,
                        onChanged: registerController.onConfirmPasswordInputChanged,
                      ),
                      const AppSpacing(v: 8),
                      AppTextInput(
                        labelText: 'ref_code_opt'.tr.toUpperCase(),
                        prefixIcon: Icon(
                          Ionicons.code,
                          color: context.colors.hintLight,
                        ),
                        backgroundColor: context.colors.primary.shade100,
                        lableStyle: TextStyle(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                        validator: registerController.validateReferralCode,
                        onChanged: registerController.onReferralInputChanged,
                      ),
                      const AppSpacing(v: 8),
                      Align(
                        alignment: Alignment.center,
                        child: DetectableText(
                          trimLines: 7,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'more',
                          trimExpandedText: '...less',
                          text: 'By signing up, you agree to our Terms & Privacy Policy.',
                          detectionRegExp: RegExp(
                            '(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent',
                            multiLine: true,
                          ),
                          callback: (bool readMore) {
                            debugPrint('Read more >>>>>>> $readMore');
                          },
                          onTap: (String tappedText) async {
                            if (tappedText.startsWith('#')) {
                              debugPrint('DetectableText >>>>>>> #');
                            } else if (tappedText.startsWith('@')) {
                              debugPrint('DetectableText >>>>>>> @');
                            } else if (tappedText.startsWith('http')) {
                              _launchURL(tappedText);
                            }
                          },
                          basicStyle: const TextStyle(
                            fontSize: 12,
                            wordSpacing: 0.5,
                          ),
                          detectedStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            wordSpacing: 0.5,
                            color: context.colors.primary,
                          ),
                        ),
                      ),
                      const AppSpacing(v: 49),
                      AppButton(
                        enabled: isWalletConnect
                            ? registerController.walletConnectRegistrationFormIsValid
                            : registerController.registrationFormIsValid,
                        borderRadius: AppBorderRadius.largeAll,
                        onPressed: () => registerController.register(
                          context,
                          isWalletConnect: isWalletConnect,
                        ),
                        child: Text(
                          'next'.tr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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

  void _launchURL(String url) async {
    if (!await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}

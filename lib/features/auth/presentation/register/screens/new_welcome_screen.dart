import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewWelcomeScreen extends StatelessWidget {
  const NewWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.lH,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(AssetImages.logo, height: 48, width: 39),
          const SizedBox(height: 32),
          SizedBox(
            width: 231.06,
            child: Text(
              'The Next Evolution of Social Media',
              style: context.h5.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF272E35)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 112),
          _SocialButton(
            image: AssetImages.wallets,
            text: 'Sign in with Wallet',
            width: 55,
            height: 24,
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          _SocialButton(
            image: AssetImages.facebookn,
            text: 'Sign in with Facebook',
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          _SocialButton(
            image: AssetImages.googlen,
            text: 'Sign in with Google',
            onPressed: () {},
          ),
          const SizedBox(height: 56),
          AppButton(
            padding: EdgeInsets.zero,
            backgroundColor: context.colors.primary,
            onPressed: () => Get.offNamed<void>(AppRoutes.newRegistration),
            child: const Text(
              'Get Started',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: context.body2,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Have an account already? ',
                      style: TextStyle(
                        color: context.colors.text,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: 'Log in',
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      style: TextStyle(
                        color: context.colors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.image,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
  });

  final String image;
  final String text;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF1B4F4A).withOpacity(0.2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(image, height: height ?? 24, width: width ?? 24),
            const SizedBox(width: 8),
            Text(text, style: context.body1.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

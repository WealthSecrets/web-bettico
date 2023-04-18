import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/social_buttons_row.dart';
import 'package:flutter/material.dart';

class RightLoginContainer extends StatelessWidget {
  const RightLoginContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool needSmallFonts = width > 1009 && width <= 1185;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppBorderRadius.smallAll,
        border: Border.all(
          color: context.colors.faintGrey,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Don\'t have an account?',
            style: TextStyle(
              fontSize: needSmallFonts ? 18 : 22,
              fontWeight: FontWeight.bold,
              color: context.colors.textDark,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Sign up now to know what\'s happening on Xviral.',
            style: TextStyle(
              fontSize: needSmallFonts ? 12 : 14,
              fontWeight: FontWeight.normal,
              color: context.colors.text,
            ),
          ),
          const SizedBox(height: 16),
          SocialButtonsRow(size: 30),
          const SizedBox(height: 16),
          AppButton(
            enabled: true,
            padding: EdgeInsets.zero,
            borderRadius: AppBorderRadius.largeAll,
            backgroundColor: context.colors.primary,
            onPressed: () =>
                WidgetUtils.showUnAuthorizedLoginContainer(context),
            child: const Text(
              'Create account',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/selectable_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomUnAthenticatedBottomNavbar extends StatelessWidget {
  const CustomUnAthenticatedBottomNavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 80),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: context.colors.primary,
        ),
        child: Row(
          children: <Widget>[
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Sign up now to know what\'s happening on Xviral.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SelectableButton(
                      text: 'Log in',
                      color: Colors.white,
                      fontSize: 14,
                      textColor: context.colors.primary,
                      onPressed: () =>
                          WidgetUtils.showUnAuthorizedLoginContainer(context),
                    ),
                    const SizedBox(width: 8),
                    SelectableButton(
                      text: 'Sign up',
                      color: Colors.white,
                      fontSize: 14,
                      textColor: context.colors.primary,
                      onPressed: () => Get.toNamed<void>(AppRoutes.login),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

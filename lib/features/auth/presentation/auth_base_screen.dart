import 'package:betticos/core/presentation/routes/auth_router.dart';
import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/presentation/utils/app_navigation_keys.dart';

class AuthBaseScreen extends StatefulWidget {
  const AuthBaseScreen({Key? key}) : super(key: key);
  static const String route = '/auth';

  @override
  State<AuthBaseScreen> createState() => _AuthBaseScreenState();
}

class _AuthBaseScreenState extends State<AuthBaseScreen> {
  RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return AppNavigationKeys.authNavKey.currentState!.maybePop();
      },
      child: SizedBox.expand(
        child: Row(
          children: <Widget>[
            SizedBox(
              height: double.infinity,
              width: MediaQuery.of(context).size.width / 2,
              child: SvgPicture.asset(
                'assets/svgs/fans.svg',
              ),
            ),
            Navigator(
              observers: <NavigatorObserver>[
                HeroController(createRectTween: _createRectTween),
              ],
              onGenerateRoute: onAuthGenerateRoute,
              initialRoute: LoginScreen.route,
            ),
          ],
        ),
      ),
    );
  }
}

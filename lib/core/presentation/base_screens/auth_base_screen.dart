import 'package:betticos/core/navigation/routers/auth_router.dart';
import 'package:flutter/material.dart';

class AuthBaseScreen extends StatelessWidget {
  AuthBaseScreen({Key? key, this.initialRoute}) : super(key: key);
  final String? initialRoute;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Navigator(
        key: _navigatorKey,
        initialRoute: initialRoute,
        onGenerateRoute: AuthRouter.router,
      ),
    );
  }
}

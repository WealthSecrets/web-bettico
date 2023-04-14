import 'package:betticos/core/core.dart';
import 'package:flutter/cupertino.dart';

import '../../../features/responsiveness/constants/web_controller.dart';

Navigator webNavigator(String initialRoute) => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: initialRoute,
    );

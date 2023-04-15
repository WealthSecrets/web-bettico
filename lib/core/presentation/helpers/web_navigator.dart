import 'package:flutter/cupertino.dart';

import '../../../features/responsiveness/constants/web_controller.dart';

Navigator webNavigator(String initialRoute) => Navigator(
      key: navigationController.navigatorKey,
      // onGenerateRoute: (RouteSettings settings) {},
      // initialRoute: initialRoute,
    );

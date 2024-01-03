import 'package:betticos/constants/constants.dart';
import 'package:flutter/cupertino.dart';

import 'router.dart';

Navigator appNavigator(String initialRoute) => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: initialRoute,
    );

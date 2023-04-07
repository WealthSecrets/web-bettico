import 'package:flutter/cupertino.dart';

import '../../../features/responsiveness/constants/web_controller.dart';
import '../routes/router.dart';

Navigator webNavigator(String initialRoute) => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: initialRoute,
    );

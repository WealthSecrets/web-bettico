import 'package:betticos/features/betticos/presentation/base/screens/base_screen.dart';
import 'package:flutter/material.dart';

import '../../core/presentation/helpers/responsiveness.dart';
import 'large_screen.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: BaseScreen(),
      ),
    );
  }
}

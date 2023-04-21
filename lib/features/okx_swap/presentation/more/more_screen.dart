import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/app_web_view.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:webviewx/webviewx.dart';

import '../widgets/custom_tile.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          right: 16.0,
          left: 16.0,
        ),
        child: AppAnimatedColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'More Services',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: context.colors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            CustomTile(
              icon: Ionicons.pricetag_outline,
              onPressed: () =>
                  navigationController.navigateTo(AppRoutes.privateSales),
              text: 'Private Pales',
            ),
            const SizedBox(height: 10),
            CustomTile(
              icon: Ionicons.link_sharp,
              onPressed: () async {
                await navigationController.navigateTo(
                  AppRoutes.appwebview,
                  arguments: AppWebViewRouteArgument(
                    title: 'Web Browser',
                    url: 'https://www.avatrade.com/',
                    navigationDelegate: (NavigationRequest navigation) async =>
                        NavigationDecision.navigate,
                  ),
                );
              },
              text: 'Avatrade',
            ),
          ],
        ),
      ),
    );
  }
}

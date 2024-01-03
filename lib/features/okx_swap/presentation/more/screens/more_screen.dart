import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, right: 16.0, left: 16.0),
        child: AppAnimatedColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (!isSmallScreen) const SizedBox(height: 16),
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Ionicons.arrow_back_sharp, size: 24, color: context.colors.black),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'More Services',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.colors.textDark),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTile(
              icon: Ionicons.bag_sharp,
              onPressed: () => navigationController.navigateTo(AppRoutes.privateSales),
              text: 'Private Sales',
            ),
            const SizedBox(height: 10),
            CustomTile(
              icon: Ionicons.link_sharp,
              onPressed: () => navigationController.navigateTo(AppRoutes.avatrade),
              text: 'Avatrade',
            ),
            const SizedBox(height: 10),
            CustomTile(
              icon: Ionicons.link_sharp,
              onPressed: () => navigationController.navigateTo(AppRoutes.creator),
              text: 'Sales',
            ),
          ],
        ),
      ),
    );
  }
}

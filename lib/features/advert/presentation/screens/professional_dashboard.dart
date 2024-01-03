import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

class ProfessionalDashboard extends StatelessWidget {
  const ProfessionalDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Professional Dashboard',
          style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: AppAnimatedColumn(
          children: <Widget>[
            OptionCard(
              imagePath: AssetImages.insight,
              title: 'Account Insights',
              subtitle: 'Accounts your accounts reached in the last 30 days',
              backgroundColor: const Color(0xFFAA7503).withOpacity(.2),
              iconColor: const Color(0xFFAA7503),
              onPressed: () => navigationController.navigateTo(AppRoutes.accountInsights),
            ),
            OptionCard(
              imagePath: AssetImages.tools,
              title: 'Ad Tools',
              subtitle: 'Manage all your ads and view ad analytics',
              backgroundColor: const Color(0xFFAA7503).withOpacity(.2),
              iconColor: const Color(0xFFAA7503),
              onPressed: () {},
            ),
            OptionCard(
              imagePath: AssetImages.boost,
              title: 'Boost Post',
              subtitle: 'Boost a post to reach more people and engagements',
              backgroundColor: const Color(0xFFAA7503).withOpacity(.2),
              iconColor: const Color(0xFFAA7503),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

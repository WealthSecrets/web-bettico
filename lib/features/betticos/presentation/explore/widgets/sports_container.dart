import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import '../screens/screens.dart';

class SportsContainer extends StatelessWidget {
  const SportsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TabBar(
                indicatorColor: context.colors.primary,
                labelColor: Colors.black,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                unselectedLabelStyle: const TextStyle(fontSize: 14),
                padding: AppPaddings.lH,
                unselectedLabelColor: Colors.grey,
                indicator: CircleTabIndicator(color: context.colors.primary, radius: 3),
                tabs: const <Tab>[Tab(text: 'Live Matches'), Tab(text: 'Fixtures'), Tab(text: 'News')],
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            SportsScreen(),
            FixturesScreen(),
            AppEmptyScreen(title: 'Coming soon!', message: 'We are working so hard to bring you the best news.'),
          ],
        ),
      ),
    );
  }
}

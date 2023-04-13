import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../profile/widgets/circle_indicator.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({Key? key, required this.searchBar}) : super(key: key);

  final Widget searchBar;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: searchBar,
          bottom: TabBar(
            indicatorColor: context.colors.primary,
            labelColor: Colors.black,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 14),
            padding: AppPaddings.lH,
            unselectedLabelColor: Colors.grey,
            indicator: CircleTabIndicator(
              color: context.colors.primary,
              radius: 3,
            ),
            tabs: const <Tab>[
              Tab(text: 'Top'),
              Tab(text: 'Latests'),
              Tab(text: 'Users'),
              Tab(text: 'Images'),
              Tab(text: 'Hashtags'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(child: Icon(Ionicons.train)),
            Center(child: Icon(Ionicons.send)),
            Center(child: Icon(Ionicons.mail)),
            Center(child: Icon(Ionicons.accessibility)),
            Center(child: Icon(Ionicons.add)),
          ],
        ),
      ),
    );
  }
}

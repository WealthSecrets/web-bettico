import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    TabBar(
                      indicatorColor: context.colors.primary,
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      unselectedLabelStyle: const TextStyle(fontSize: 14),
                      padding: AppPaddings.lH.add(AppPaddings.lB),
                      unselectedLabelColor: Colors.grey,
                      indicator: CircleTabIndicator(color: context.colors.primary, radius: 3),
                      tabs: const <Widget>[
                        Tab(text: 'All', key: Key('all')),
                        Tab(text: 'Mentions', key: Key('mentions')),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: const TabBarView(
              children: <Widget>[
                AllNotificationScreens(),
                SizedBox(child: Center(child: Text('Mentions'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

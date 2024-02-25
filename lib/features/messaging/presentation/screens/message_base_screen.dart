import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

class MessageBaseScreen extends StatelessWidget {
  const MessageBaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: context.colors.primary,
        child: Center(
          child: Image.asset(AppAssetIcons.chatPlus, height: 29, width: 29, color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: AppPaddings.lH,
            child: SearchField(
              fillColor: const Color(0xFFF5F8FF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11.0),
                borderSide: const BorderSide(color: Color(0xFFF5F8FF)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11.0),
                borderSide: const BorderSide(color: Color(0xFFF5F8FF)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: DefaultTabController(
              length: 3,
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
                              Tab(text: 'Inbox', key: Key('inbox')),
                              Tab(text: 'Creator Box', key: Key('creator_box')),
                            ],
                          ),
                        ),
                        pinned: true,
                      ),
                    ];
                  },
                  body: const TabBarView(
                    children: <Widget>[
                      AllMessagesScreen(),
                      InboxScreen(),
                      CreatorBoxScreen(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

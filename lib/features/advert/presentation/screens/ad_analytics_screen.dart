import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AdAnalyticsScreenRouteArgument {
  const AdAnalyticsScreenRouteArgument({required this.post});

  final Post post;
}

class AdAnalyticsScreen extends StatelessWidget {
  const AdAnalyticsScreen({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ad Analytics',
          style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TimelineCard(post: post, hideButtons: true, hideOptions: true, sponsored: post.boosted == true),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const _ActionCard(iconData: Ionicons.eye_sharp, count: '30'),
                _ActionCard(iconData: Ionicons.thumbs_up_sharp, count: post.likeUsers.length.toString()),
                _ActionCard(iconData: Ionicons.chatbubble, count: post.comments.toString()),
                _ActionCard(iconData: Ionicons.share, count: post.shares.length.toString()),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[BoxShadow(blurRadius: 5, color: Colors.black12, offset: Offset(0, 1))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Overview',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: context.colors.black),
                  ),
                  const SizedBox(height: 16),
                  const _TitleText(title: 'Accounts Reached', count: '1500'),
                  const SizedBox(height: 8),
                  const _TitleText(title: 'Accounts Engaged', count: '540'),
                  const SizedBox(height: 8),
                  const _TitleText(title: 'Profile Activity', count: '50'),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[BoxShadow(blurRadius: 5, color: Colors.black12, offset: Offset(0, 1))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Reach & Engagements',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: context.colors.black),
                  ),
                  const SizedBox(height: 16),
                  const _TitleText(title: 'Accounts Reached', count: '500'),
                  const SizedBox(height: 8),
                  const _TitleText(title: 'Impressions', count: '750'),
                  const SizedBox(height: 8),
                  const _TitleText(title: 'Engagements', count: '50'),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[BoxShadow(blurRadius: 5, color: Colors.black12, offset: Offset(0, 1))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Profile Activity',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: context.colors.black),
                  ),
                  const SizedBox(height: 16),
                  const _TitleText(title: 'Profile Views', count: '10'),
                  const SizedBox(height: 8),
                  const _TitleText(title: 'Follows', count: '10'),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({required this.title, required this.count});
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: context.colors.black),
        ),
        Text(
          count,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: context.colors.text),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.iconData, required this.count});

  final IconData iconData;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const <BoxShadow>[BoxShadow(blurRadius: 5, color: Colors.black12, offset: Offset(0, 1))],
      ),
      child: Column(
        children: <Widget>[
          Icon(iconData, color: context.colors.primary, size: 20),
          Text(
            count,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: context.colors.text),
          ),
        ],
      ),
    );
  }
}

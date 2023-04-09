import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TrendsForYouScreen extends StatelessWidget {
  const TrendsForYouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: AppAnimatedColumn(children: <Widget>[
        Text(
          'Trends for you',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.colors.black,
          ),
        ),
        const SizedBox(height: 16),
        const _TrendCard(
          title: 'Tredning in Ghana',
          hashtag: 'Asake',
          count: '1234',
        ),
        const _TrendCard(
          title: 'Tredning in Ghana',
          hashtag: 'Asake',
          count: '1234',
        ),
        const _TrendCard(
          title: 'Tredning in Ghana',
          hashtag: 'Asake',
          count: '1234',
        ),
        const _TrendCard(
          title: 'Tredning in Ghana',
          hashtag: 'Asake',
          count: '1234',
        ),
        const _TrendCard(
          title: 'Tredning in Ghana',
          hashtag: 'Asake',
          count: '1234',
        ),
      ]),
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard(
      {Key? key,
      required this.title,
      required this.hashtag,
      required this.count})
      : super(key: key);
  final String title;
  final String hashtag;
  final String count;

  @override
  Widget build(BuildContext context) {
    final TextStyle trendStyle = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: context.colors.textDark,
    );
    const SizedBox space = SizedBox(height: 1);
    return Container(
      width: double.infinity,
      margin: AppPaddings.mB,
      padding: AppPaddings.mA,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 5,
            color: Colors.black12,
            offset: Offset(0, 1),
          )
        ],
        borderRadius: AppBorderRadius.smallAll,
        border: Border.all(
          color: context.colors.faintGrey,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: trendStyle,
              ),
              space,
              Text(
                hashtag,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: context.colors.black),
              ),
              space,
              Text(
                '$count Posts',
                style: trendStyle,
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: Icon(
              Ionicons.ellipsis_vertical_sharp,
              color: context.colors.text,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}

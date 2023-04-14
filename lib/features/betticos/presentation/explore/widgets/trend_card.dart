import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TrendCard extends StatelessWidget {
  const TrendCard({
    Key? key,
    required this.title,
    required this.hashtag,
    required this.count,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final String hashtag;
  final String count;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final TextStyle trendStyle = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: isSelected ? context.colors.faintGrey : context.colors.textDark,
    );
    const SizedBox space = SizedBox(height: 1);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        margin: AppPaddings.mB,
        padding: AppPaddings.mA,
        decoration: BoxDecoration(
          color: isSelected ? context.colors.primary : Colors.white,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 5,
              color: Colors.black12,
              offset: Offset(0, 1),
            )
          ],
          borderRadius: AppBorderRadius.smallAll,
          border: isSelected
              ? null
              : Border.all(
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
                    color: isSelected ? Colors.white : context.colors.black,
                  ),
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
                color:
                    isSelected ? context.colors.faintGrey : context.colors.text,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

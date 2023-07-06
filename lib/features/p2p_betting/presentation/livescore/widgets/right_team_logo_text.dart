import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class RightTeamLogoText extends StatelessWidget {
  const RightTeamLogoText({
    super.key,
    required this.title,
    required this.initials,
    this.logoSize = 40,
  });

  final String title;
  final String initials;
  final double logoSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 16.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: context.colors.black,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}

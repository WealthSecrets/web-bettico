import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

class ScoreRow extends StatelessWidget {
  const ScoreRow({super.key, required this.awayName, required this.homeName, required this.score, required this.time});

  final String awayName;
  final String homeName;
  final String score;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: LeftTeamLogoText(title: awayName, initials: StringUtils.getInitials(awayName)),
        ),
        const AppSpacing(h: 5),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              score,
              style: TextStyle(fontWeight: FontWeight.bold, color: context.colors.black, fontSize: 12),
            ),
            const SizedBox(height: 5),
            ChipCard(
              child: Text(
                time,
                style: TextStyle(color: context.colors.text, fontWeight: FontWeight.bold, fontSize: 10),
              ),
            )
          ],
        ),
        const SizedBox(width: 5),
        Expanded(child: RightTeamLogoText(initials: StringUtils.getInitials(homeName), title: homeName)),
      ],
    );
  }
}

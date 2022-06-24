// flutter package
import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/chip.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/left_team_logo_text.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/right_team_logo_text.dart';
import 'package:flutter/material.dart';

class ScoreRow extends StatelessWidget {
  const ScoreRow({
    Key? key,
    required this.awayName,
    required this.homeName,
    required this.score,
    required this.time,
  }) : super(key: key);

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
          flex: 1,
          child: LeftTeamLogoText(
            title: awayName,
            initials: StringUtils.getInitials(awayName),
          ),
        ),
        const AppSpacing(h: 5),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              score,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.colors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            ChipCard(
              child: Text(
                time,
                style: TextStyle(
                  color: context.colors.text,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            )
          ],
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 1,
          child: RightTeamLogoText(
            initials: StringUtils.getInitials(homeName),
            title: homeName,
          ),
        ),
      ],
    );
  }
}

import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/time_card.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '/features/p2p_betting/presentation/p2p_betting/widgets/match_avatar.dart';
import '../../livescore/widgets/chip.dart';

class P2PBettingCard extends StatefulWidget {
  const P2PBettingCard({
    Key? key,
    // this.match,
    // this.fixture,
    required this.awayTeam,
    required this.homeTeam,
    required this.score,
    this.time,
    this.date,
    this.awayDisabled = false,
    this.homeDisabled = false,
    this.onAwayPressed,
    this.onHomePressed,
  }) : super(key: key);

  // final SoccerMatch? match;
  // final Fixture? fixture;
  final Team awayTeam;
  final Team homeTeam;
  final String score;
  final String? time;
  final String? date;
  final bool? awayDisabled;
  final bool? homeDisabled;
  final Function()? onAwayPressed;
  final Function()? onHomePressed;

  @override
  State<P2PBettingCard> createState() => _P2PBettingCardState();
}

class _P2PBettingCardState extends State<P2PBettingCard> {
  final P2PBetController p2pBetController = Get.find<P2PBetController>();

  List<String> score = <String>[];

  @override
  Widget build(BuildContext context) {
    score = widget.score.split(' ');

    return Container(
      padding: AppPaddings.lV.add(AppPaddings.sH),
      width: MediaQuery.of(context).size.width,
      margin: AppPaddings.sV.add(AppPaddings.sT),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colors.cardColor,
          width: 1,
        ),
        borderRadius: AppBorderRadius.smallAll,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (widget.awayDisabled ?? false)
                  MatchAvatar(
                    name: widget.awayTeam.name,
                    selected: widget.awayDisabled ??
                        p2pBetController.teamSelected.value ==
                            widget.awayTeam.name,
                    disabled: widget.awayDisabled,
                    onPressed: widget.onAwayPressed,
                  )
                else
                  Obx(
                    () => MatchAvatar(
                      name: widget.awayTeam.name,
                      selected: p2pBetController.teamSelected.value ==
                          widget.awayTeam.name,
                      disabled: widget.awayDisabled,
                      onPressed: widget.onAwayPressed,
                    ),
                  ),
                const AppSpacing(v: 8),
                Text(
                  widget.awayTeam.name,
                  style: TextStyle(
                    color: context.colors.black,
                    fontSize: 10,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    score.first,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  const AppSpacing(h: 5),
                  const Text(
                    '-',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const AppSpacing(h: 5),
                  Text(
                    score.last,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const AppSpacing(v: 8),
              if (widget.date != null && widget.time != null)
                TimeCard(
                  dateTime: DateTime.parse(
                    widget.date! + ' ' + widget.time!,
                  ),
                )
              else
                ChipCard(
                  child: Padding(
                    padding: AppPaddings.sH,
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Ionicons.time,
                          size: 18,
                        ),
                        const AppSpacing(h: 5),
                        Text(
                          '${widget.time}\'',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: context.colors.text,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (widget.homeDisabled ?? false)
                  MatchAvatar(
                    name: widget.homeTeam.name,
                    selected: widget.homeDisabled ??
                        p2pBetController.teamSelected.value ==
                            widget.homeTeam.name,
                    disabled: widget.homeDisabled,
                    onPressed: widget.onHomePressed,
                  )
                else
                  Obx(
                    () => MatchAvatar(
                      name: widget.homeTeam.name,
                      selected: p2pBetController.teamSelected.value ==
                          widget.homeTeam.name,
                      disabled: widget.homeDisabled,
                      onPressed: widget.onHomePressed,
                    ),
                  ),
                const AppSpacing(v: 8),
                Text(
                  widget.homeTeam.name,
                  style: TextStyle(
                    color: context.colors.black,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

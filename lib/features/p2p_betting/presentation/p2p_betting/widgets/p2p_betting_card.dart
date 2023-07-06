import 'package:betticos/features/p2p_betting/data/models/sportmonks/time/time.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '/features/p2p_betting/presentation/p2p_betting/widgets/match_avatar.dart';
import '../../livescore/widgets/chip.dart';

class P2PBettingCard extends StatefulWidget {
  const P2PBettingCard({
    super.key,
    required this.awayTeam,
    required this.homeTeam,
    required this.localTeamScore,
    required this.visitorTeamScore,
    this.time,
    this.awayDisabled = false,
    this.homeDisabled = false,
    this.onAwayPressed,
    this.onHomePressed,
  });

  final Team awayTeam;
  final Team homeTeam;
  final int localTeamScore;
  final int visitorTeamScore;
  final Time? time;
  final bool? awayDisabled;
  final bool? homeDisabled;
  final Function()? onAwayPressed;
  final Function()? onHomePressed;

  @override
  State<P2PBettingCard> createState() => _P2PBettingCardState();
}

class _P2PBettingCardState extends State<P2PBettingCard> {
  final P2PBetController p2pBetController = Get.find<P2PBetController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.lV.add(AppPaddings.sH),
      width: MediaQuery.of(context).size.width,
      margin: AppPaddings.sV.add(AppPaddings.sT),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.cardColor),
        borderRadius: AppBorderRadius.smallAll,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Column(
              children: <Widget>[
                if (widget.homeDisabled ?? false)
                  MatchAvatar(
                    logo: widget.homeTeam.logo,
                    selected: widget.homeDisabled ?? p2pBetController.teamSelected.value == widget.homeTeam.name,
                    disabled: widget.homeDisabled,
                    onPressed: widget.onHomePressed,
                  )
                else
                  Obx(
                    () => MatchAvatar(
                      logo: widget.homeTeam.logo,
                      selected: p2pBetController.teamSelected.value == widget.homeTeam.name,
                      disabled: widget.homeDisabled,
                      onPressed: widget.onHomePressed,
                    ),
                  ),
                const AppSpacing(v: 8),
                Text(
                  widget.homeTeam.name,
                  style: TextStyle(color: context.colors.black, fontSize: 10),
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
                    widget.localTeamScore.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
                  ),
                  const AppSpacing(h: 5),
                  const Text(
                    '-',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const AppSpacing(h: 5),
                  Text(
                    widget.visitorTeamScore.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
                  ),
                ],
              ),
              const AppSpacing(v: 8),
              if (widget.time != null)
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
                          widget.time!.status?.toLowerCase() == 'ns'
                              ? 'NS'
                              : widget.time!.status?.toLowerCase() == 'live'
                                  ? '${widget.time!.minute}\''
                                  : '${widget.time!.status}',
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
              children: <Widget>[
                if (widget.awayDisabled ?? false)
                  MatchAvatar(
                    logo: widget.awayTeam.name,
                    selected: widget.awayDisabled ?? p2pBetController.teamSelected.value == widget.awayTeam.name,
                    disabled: widget.awayDisabled,
                    onPressed: widget.onAwayPressed,
                  )
                else
                  Obx(
                    () => MatchAvatar(
                      logo: widget.awayTeam.logo,
                      selected: p2pBetController.teamSelected.value == widget.awayTeam.name,
                      disabled: widget.awayDisabled,
                      onPressed: widget.onAwayPressed,
                    ),
                  ),
                const AppSpacing(v: 8),
                Text(
                  widget.awayTeam.name,
                  style: TextStyle(color: context.colors.black, fontSize: 12),
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

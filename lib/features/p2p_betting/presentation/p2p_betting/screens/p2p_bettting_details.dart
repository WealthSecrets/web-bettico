import 'package:betticos/core/presentation/utils/app_endpoints.dart';
import 'package:betticos/features/p2p_betting/data/models/bet/bet.dart';
import 'package:betticos/features/p2p_betting/data/models/bettor/bettor.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '../widgets/p2p_betting_card.dart';

class P2PBettingDetailsScreen extends StatefulWidget {
  const P2PBettingDetailsScreen({
    Key? key,
    required this.bet,
  }) : super(key: key);
  final Bet bet;

  @override
  State<StatefulWidget> createState() => _P2PBettingDetailsScreenState();
}

class _P2PBettingDetailsScreenState extends State<P2PBettingDetailsScreen> {
  final P2PBetController controller = Get.find<P2PBetController>();
  // final LiveScoreArguments? args = Get.arguments as LiveScoreArguments?;

  // @override
  // void initState() {
  //   super.initState();
  //   if (args != null) {
  //     controller.setCompetitionId(args!.match.competitionId);
  //     controller.setMatch(args!.match);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leading: const Align(
            alignment: Alignment(0, -.8),
            child: AppBackButton(),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '${StringUtils.capitalizeFirst(widget.bet.creator.user.firstName!)}\'s Bet',
                textScaleFactor: 1.0,
                style: context.body1.copyWith(
                  color: context.colors.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Accept ${StringUtils.capitalizeFirst(widget.bet.creator.user.firstName!)}\'s bet to compete with him',
                textScaleFactor: 1.0,
                style: context.caption.copyWith(
                  color: context.colors.textDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        body: Obx(
          () => AppLoadingBox(
            loading: controller.isUpdatingBet.value,
            child: SingleChildScrollView(
              padding: AppPaddings.lA,
              child: AppAnimatedColumn(
                duration: const Duration(milliseconds: 1000),
                direction: Axis.horizontal,
                children: <Widget>[
                  P2PBettingCard(
                    awayTeam: Team(
                      name: widget.bet.awayTeam.name,
                      teamId: widget.bet.awayTeam.teamId,
                    ),
                    homeTeam: Team(
                      name: widget.bet.homeTeam.name,
                      teamId: widget.bet.homeTeam.teamId,
                    ),
                    score: widget.bet.score ?? '? - ?',
                    time: widget.bet.time,
                    date: widget.bet.date,
                    onAwayPressed:
                        widget.bet.creator.teamId != widget.bet.awayTeam.teamId
                            ? () => controller.selectTeam(
                                  widget.bet.awayTeam.name,
                                  widget.bet.awayTeam.teamId,
                                )
                            : null,
                    onHomePressed:
                        widget.bet.creator.teamId != widget.bet.homeTeam.teamId
                            ? () => controller.selectTeam(
                                  widget.bet.homeTeam.name,
                                  widget.bet.homeTeam.teamId,
                                )
                            : null,
                    awayDisabled:
                        widget.bet.creator.teamId == widget.bet.awayTeam.teamId,
                    homeDisabled:
                        widget.bet.creator.teamId == widget.bet.homeTeam.teamId,
                  ),
                  const AppSpacing(v: 30),
                  Text(
                    'Creator of Bet',
                    style: context.caption.copyWith(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const AppSpacing(v: 8),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${AppEndpoints.userImages}/${widget.bet.creator.user.photo}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const AppSpacing(h: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${widget.bet.creator.user.firstName} ${widget.bet.creator.user.lastName}',
                              style: context.body2.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '@${widget.bet.creator.user.username}',
                              style: context.caption.copyWith(
                                color: context.colors.grey,
                              ),
                            ),
                            const AppSpacing(v: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const AppSpacing(v: 30),
                  Text(
                    'Choose your bet',
                    style: context.caption.copyWith(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const AppSpacing(v: 8),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AppConstrainedButton(
                          text: 'Win',
                          borderRadius: AppBorderRadius.mediumAll,
                          color: context.colors.success,
                          textColor: Colors.white,
                          onPressed: () => controller.selectChoice('win'),
                          selected:
                              widget.bet.creator.choice == BettorChoice.win ||
                                  controller.choice.value == 'win',
                          disabled:
                              widget.bet.creator.choice == BettorChoice.win,
                        ),
                        AppConstrainedButton(
                          text: 'Draw',
                          borderRadius: AppBorderRadius.mediumAll,
                          color: context.colors.primary,
                          textColor: Colors.white,
                          onPressed: () => controller.selectChoice('draw'),
                          selected:
                              widget.bet.creator.choice == BettorChoice.draw ||
                                  controller.choice.value == 'draw',
                          disabled:
                              widget.bet.creator.choice == BettorChoice.draw,
                        ),
                        AppConstrainedButton(
                          text: 'Loss',
                          borderRadius: AppBorderRadius.mediumAll,
                          color: context.colors.error,
                          textColor: Colors.white,
                          onPressed: () => controller.selectChoice('loss'),
                          selected:
                              widget.bet.creator.choice == BettorChoice.loss ||
                                  controller.choice.value == 'loss',
                          disabled:
                              widget.bet.creator.choice == BettorChoice.loss,
                        )
                      ],
                    ),
                  ),
                  const AppSpacing(v: 70),
                  Obx(
                    () => AppButton(
                      onPressed: () => controller.addOpponentToBet(
                        context,
                        widget.bet.id,
                      ),
                      enabled: controller.isDetailsValid,
                      borderRadius: AppBorderRadius.largeAll,
                      child: Text(
                        'Accept Bet Request'.toUpperCase(),
                        style: context.body2.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const AppSpacing(v: 40),
                  Text(
                    'P2P Betting is risky.\nBet depending on how much you can afford.\nNo limits on how many bets you can create.\nBet is finalized when opponent accepts bet request.',
                    style: context.caption.copyWith(
                      color: context.colors.textDark,
                    ),
                  ),
                  const AppSpacing(v: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

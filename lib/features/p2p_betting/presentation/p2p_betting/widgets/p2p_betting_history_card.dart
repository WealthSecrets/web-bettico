import 'dart:async';

import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/p2p_betting/data/models/bet/bet.dart';
import 'package:betticos/features/p2p_betting/data/models/bettor/bettor.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/time_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';

class P2PBettingHistoryCard extends StatefulWidget {
  const P2PBettingHistoryCard({
    Key? key,
    required this.bet,
    this.onPressed,
  }) : super(key: key);

  final Bet bet;
  final Function()? onPressed;

  @override
  State<P2PBettingHistoryCard> createState() => _P2PBettingHistoryCardState();
}

class _P2PBettingHistoryCardState extends State<P2PBettingHistoryCard> {
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();
  final P2PBetController p2pBetController = Get.find<P2PBetController>();

  Timer? _timer;

  final StreamController<LiveScore?> _liveScoreStreamController = StreamController<LiveScore?>.broadcast();

  @override
  void initState() {
    super.initState();

    startBroadcast(widget.bet.competitionId);
  }

  @override
  void dispose() {
    _liveScoreStreamController.close();
    _timer?.cancel();
    super.dispose();
  }

  void startBroadcast(int fixtureId) async {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
      final LiveScore? sFixture = await lController.getMatchSFixture(fixtureId);

      _liveScoreStreamController.add(sFixture);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LiveScore?>(
      stream: _liveScoreStreamController.stream,
      builder: (BuildContext context, AsyncSnapshot<LiveScore?> snapshot) {
        final LiveScore? liveScore = snapshot.data;
        if (snapshot.hasData && snapshot.data != null) {
          final LiveScore liveScoreData = snapshot.data!;
          String? winner;
          if (liveScoreData.time.status?.toLowerCase() == 'ft') {
            if ((widget.bet.creator.teamId == liveScoreData.localTeamId) &&
                (liveScoreData.scores!.localTeamScore > liveScoreData.scores!.visitorTeamScore) &&
                widget.bet.creator.choice == BettorChoice.win) {
              winner = widget.bet.creator.id;
            } else if ((widget.bet.creator.teamId == liveScoreData.localTeamId) &&
                (liveScoreData.scores!.localTeamScore < liveScoreData.scores!.visitorTeamScore) &&
                widget.bet.creator.choice == BettorChoice.loss) {
              winner = widget.bet.creator.id;
            } else if ((widget.bet.opponent?.teamId == liveScoreData.localTeamId) &&
                (liveScoreData.scores!.localTeamScore < liveScoreData.scores!.visitorTeamScore) &&
                widget.bet.opponent?.choice == BettorChoice.loss) {
              winner = widget.bet.opponent?.id;
            } else if ((widget.bet.opponent?.teamId == liveScoreData.localTeamId) &&
                (liveScoreData.scores!.localTeamScore > liveScoreData.scores!.visitorTeamScore) &&
                widget.bet.opponent?.choice == BettorChoice.win) {
              winner = widget.bet.opponent?.id;
            } else if (widget.bet.creator.choice == BettorChoice.draw &&
                (liveScoreData.scores!.localTeamScore == liveScoreData.scores!.visitorTeamScore)) {
              winner = widget.bet.creator.id;
            } else if (widget.bet.opponent?.choice == BettorChoice.draw &&
                (liveScoreData.scores!.localTeamScore == liveScoreData.scores!.visitorTeamScore)) {
              winner = widget.bet.opponent?.id;
            }
          }
          p2pBetController.addStatusScoreToBet(
            betId: widget.bet.id,
            score: '${liveScoreData.scores!.localTeamScore} : ${liveScoreData.scores!.visitorTeamScore}',
            status: liveScoreData.time.status?.toLowerCase() ?? 'h1',
            winner: winner,
          );
        }
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 4).add(
            const EdgeInsets.only(top: 4),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colors.cardColor,
              width: 1,
            ),
            borderRadius: AppBorderRadius.smallAll,
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: widget.onPressed,
            child: Padding(
              padding: ResponsiveWidget.isSmallScreen(context)
                  ? const EdgeInsets.symmetric(horizontal: 16)
                  : const EdgeInsets.symmetric(vertical: 16).add(
                      const EdgeInsets.symmetric(horizontal: 38),
                    ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (widget.bet.date != null &&
                          (liveScore != null && liveScore.time.status?.toLowerCase() == 'ns'))
                        TimeCard(dateTime: DateTime.parse(widget.bet.date!)),
                      if (liveScore != null && liveScore.time.status?.toLowerCase() == 'live')
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: context.colors.primary.withOpacity(.2),
                            border: Border.all(
                              color: context.colors.primary,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Text(
                            liveScore.time.status?.toLowerCase() == 'ns'
                                ? 'NS'
                                : liveScore.time.status?.toLowerCase() == 'live'
                                    ? '${liveScore.time.minute}\''
                                    : '${liveScore.time.status}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: context.colors.primary,
                            ),
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8).add(const EdgeInsets.symmetric(vertical: 4)),
                        decoration: BoxDecoration(
                          borderRadius: AppBorderRadius.largeAll,
                          color: widget.bet.status.color(context).withOpacity(.3),
                          border: Border.all(
                            color: widget.bet.status.color(context),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          widget.bet.status.stringValue.toUpperCase(),
                          style: TextStyle(
                            fontSize: ResponsiveWidget.isSmallScreen(context) ? 8 : 10,
                            // fontWeight: FontWeight.w700,
                            fontWeight: ResponsiveWidget.isSmallScreen(context) ? FontWeight.w700 : FontWeight.normal,
                            color: widget.bet.status.color(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveWidget.isSmallScreen(context) ? 8 : 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (widget.bet.homeTeam.logo != null)
                              Container(
                                height: 60,
                                width: 60,
                                padding: AppPaddings.lA,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: widget.bet.creator.teamId == widget.bet.homeTeam.teamId
                                        ? widget.bet.creator.choice.color(context)
                                        : widget.bet.opponent != null
                                            ? widget.bet.opponent!.teamId == widget.bet.homeTeam.teamId
                                                ? widget.bet.opponent!.choice.color(context)
                                                : context.colors.text
                                            : context.colors.text,
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      widget.bet.homeTeam.logo!,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            SizedBox(
                              height: ResponsiveWidget.isSmallScreen(context) ? 8 : 12,
                            ),
                            Text(
                              widget.bet.homeTeam.name,
                              style: TextStyle(
                                color: context.colors.black,
                                fontSize: ResponsiveWidget.isSmallScreen(context) ? 12 : 14,
                                fontWeight:
                                    ResponsiveWidget.isSmallScreen(context) ? FontWeight.bold : FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 60,
                        child: Column(
                          children: <Widget>[
                            Text(
                              snapshot.hasData && snapshot.data != null
                                  ? '${snapshot.data!.scores?.localTeamScore} - ${snapshot.data!.scores?.visitorTeamScore}'
                                  : widget.bet.score ?? '? - ?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.colors.text,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveWidget.isSmallScreen(context) ? 8 : 12,
                            ),
                            Container(
                              padding: ResponsiveWidget.isSmallScreen(context)
                                  ? const EdgeInsets.symmetric(vertical: 4)
                                      .add(const EdgeInsets.symmetric(horizontal: 8))
                                  : const EdgeInsets.symmetric(vertical: 4)
                                      .add(const EdgeInsets.symmetric(horizontal: 16)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: widget.bet.status.color(context),
                              ),
                              child: Center(
                                child: Text(
                                  widget.bet.status.stringAmount(widget.bet.amount),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                        ResponsiveWidget.isSmallScreen(context) ? FontWeight.bold : FontWeight.normal,
                                    decoration:
                                        widget.bet.status == BetStatus.cancelled ? TextDecoration.lineThrough : null,
                                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 12 : 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (widget.bet.awayTeam.logo != null)
                              Container(
                                height: 60,
                                width: 60,
                                padding: AppPaddings.lA,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: widget.bet.creator.teamId == widget.bet.awayTeam.teamId
                                        ? widget.bet.creator.choice.color(context)
                                        : widget.bet.opponent != null
                                            ? widget.bet.opponent!.teamId == widget.bet.awayTeam.teamId
                                                ? widget.bet.opponent!.choice.color(context)
                                                : context.colors.text
                                            : context.colors.text,
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      widget.bet.awayTeam.logo!,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            SizedBox(
                              height: ResponsiveWidget.isSmallScreen(context) ? 8 : 12,
                            ),
                            Text(
                              widget.bet.awayTeam.name,
                              style: TextStyle(
                                color: context.colors.black,
                                fontWeight:
                                    ResponsiveWidget.isSmallScreen(context) ? FontWeight.bold : FontWeight.normal,
                                fontSize: ResponsiveWidget.isSmallScreen(context) ? 12 : 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppConstrainedButton(
                    disabled: !bController.isYou(widget.bet.winner?.id) && !(widget.bet.payout ?? false),
                    color: context.colors.success,
                    textColor: Colors.white,
                    selected: true,
                    text: 'Cashout',
                    onPressed: () async {
                      // get the winner's wallet address
                      if (widget.bet.winner != null) {
                        String? walletAddress;
                        if (widget.bet.winner?.id == widget.bet.creator.id) {
                          walletAddress = widget.bet.creator.wallet;
                        } else if (widget.bet.winner?.id == widget.bet.opponent?.id) {
                          walletAddress = widget.bet.opponent?.wallet;
                        }
                        if (walletAddress != null && (widget.bet.payout ?? false)) {
                          lController.convertAmount(context, 'wsc', widget.bet.amount * 2);

                          final String? feedback = await lController.payout(
                            context,
                            walletAddress,
                            lController.convertedAmount.value,
                          );

                          if (feedback != null) {
                            p2pBetController.closePayout(
                              betId: widget.bet.id,
                            );
                          }
                        } else {
                          await AppSnacks.show(
                            context,
                            message: 'Cashout not allowed',
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

extension BetStatusX on BetStatus {
  Color color(BuildContext context) {
    switch (this) {
      case BetStatus.awaiting:
        return context.colors.yellow;
      case BetStatus.ongoing:
        return context.colors.success;
      case BetStatus.completed:
        return context.colors.success;
      case BetStatus.cancelled:
        return context.colors.error;
    }
  }

  String stringAmount(double amount) {
    switch (this) {
      case BetStatus.awaiting:
        return '\$$amount?';
      case BetStatus.ongoing:
        return '\$$amount';
      case BetStatus.cancelled:
        return '\$$amount';
      case BetStatus.completed:
        return '\$$amount';
    }
  }
}

extension BettorChoiceX on BettorChoice {
  Color color(BuildContext context) {
    switch (this) {
      case BettorChoice.win:
        return context.colors.success;
      case BettorChoice.draw:
        return context.colors.yellow;
      case BettorChoice.loss:
        return context.colors.error;
    }
  }
}

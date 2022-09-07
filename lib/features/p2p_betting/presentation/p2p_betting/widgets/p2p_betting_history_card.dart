import 'dart:async';

import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/p2p_betting/data/models/bet/bet.dart';
import 'package:betticos/features/p2p_betting/data/models/bettor/bettor.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/time_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';

class P2PBettingHistoryCard extends StatefulWidget {
  P2PBettingHistoryCard({
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

  Timer? _timer;

  final StreamController<LiveScore?> _liveScoreStreamController =
      StreamController<LiveScore?>.broadcast();

  @override
  void initState() {
    super.initState();

    // Future<void>.delayed(
    //   const Duration(seconds: 60),
    //   () => startBroadcast(widget.bet.competitionId),
    // );
  }

  @override
  void dispose() {
    _liveScoreStreamController.close();
    _timer?.cancel();
    super.dispose();
  }

  void startBroadcast(int fixtureId) async {
    _timer = Timer.periodic(const Duration(seconds: 60), (Timer timer) async {
      final LiveScore? sFixture = await lController.getMatchSFixture(fixtureId);
      _liveScoreStreamController.add(sFixture);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LiveScore?>(
      builder: (BuildContext context, AsyncSnapshot<LiveScore?> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final LiveScore liveScoreData = snapshot.data!;
          if (liveScoreData.time.status?.toLowerCase() == 'ft') {
            if (liveScoreData.scores != null) {
              if ((widget.bet.creator.teamId == liveScoreData.localTeamId) &&
                  (liveScoreData.scores!.localTeamScore >
                      liveScoreData.scores!.visitorTeamScore) &&
                  widget.bet.creator.choice == BettorChoice.win) {
                lController.convertAmount(
                    context, 'wsc', widget.bet.amount * 2);

                lController.payout(
                  context,
                  widget.bet.creator.wallet,
                  lController.convertedAmount.value,
                );
              } else if ((widget.bet.creator.teamId ==
                      liveScoreData.localTeamId) &&
                  (liveScoreData.scores!.localTeamScore <
                      liveScoreData.scores!.visitorTeamScore) &&
                  widget.bet.creator.choice == BettorChoice.loss) {
                lController.convertAmount(
                    context, 'wsc', widget.bet.amount * 2);

                lController.payout(
                  context,
                  widget.bet.creator.wallet,
                  lController.convertedAmount.value,
                );
              } else if ((widget.bet.opponent?.teamId ==
                      liveScoreData.localTeamId) &&
                  (liveScoreData.scores!.localTeamScore <
                      liveScoreData.scores!.visitorTeamScore) &&
                  widget.bet.opponent?.choice == BettorChoice.loss) {
                lController.convertAmount(
                    context, 'wsc', widget.bet.amount * 2);

                if (widget.bet.opponent != null) {
                  lController.payout(
                    context,
                    widget.bet.opponent!.wallet,
                    lController.convertedAmount.value,
                  );
                }
              } else if ((widget.bet.opponent?.teamId ==
                      liveScoreData.localTeamId) &&
                  (liveScoreData.scores!.localTeamScore >
                      liveScoreData.scores!.visitorTeamScore) &&
                  widget.bet.opponent?.choice == BettorChoice.win) {
                lController.convertAmount(
                    context, 'wsc', widget.bet.amount * 2);

                if (widget.bet.opponent != null) {
                  lController.payout(
                    context,
                    widget.bet.opponent!.wallet,
                    lController.convertedAmount.value,
                  );
                }
              }
            }
          }
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
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (widget.bet.date != null)
                        TimeCard(dateTime: DateTime.parse(widget.bet.date!)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8)
                            .add(const EdgeInsets.symmetric(vertical: 4)),
                        decoration: BoxDecoration(
                          borderRadius: AppBorderRadius.largeAll,
                          color:
                              widget.bet.status.color(context).withOpacity(.3),
                          border: Border.all(
                            color: widget.bet.status.color(context),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          widget.bet.status.stringValue.toUpperCase(),
                          style: TextStyle(
                            fontSize: ResponsiveWidget.isSmallScreen(context)
                                ? 8
                                : 10,
                            // fontWeight: FontWeight.w700,
                            fontWeight: ResponsiveWidget.isSmallScreen(context)
                                ? FontWeight.w700
                                : FontWeight.normal,
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
                                    color: widget.bet.creator.teamId ==
                                            widget.bet.homeTeam.teamId
                                        ? widget.bet.creator.choice
                                            .color(context)
                                        : widget.bet.opponent != null
                                            ? widget.bet.opponent!.teamId ==
                                                    widget.bet.homeTeam.teamId
                                                ? widget.bet.opponent!.choice
                                                    .color(context)
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
                              height: ResponsiveWidget.isSmallScreen(context)
                                  ? 8
                                  : 12,
                            ),
                            Text(
                              widget.bet.homeTeam.name,
                              style: TextStyle(
                                color: context.colors.black,
                                fontSize:
                                    ResponsiveWidget.isSmallScreen(context)
                                        ? 12
                                        : 14,
                                fontWeight:
                                    ResponsiveWidget.isSmallScreen(context)
                                        ? FontWeight.bold
                                        : FontWeight.normal,
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
                                  ? '${snapshot.data!.scores?.localTeamScore}'
                                  : widget.bet.score ?? '? - ?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.colors.text,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveWidget.isSmallScreen(context)
                                  ? 8
                                  : 12,
                            ),
                            Container(
                              padding: ResponsiveWidget.isSmallScreen(context)
                                  ? const EdgeInsets.symmetric(vertical: 4).add(
                                      const EdgeInsets.symmetric(horizontal: 8))
                                  : const EdgeInsets.symmetric(vertical: 4).add(
                                      const EdgeInsets.symmetric(
                                          horizontal: 16)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: widget.bet.status.color(context),
                              ),
                              child: Center(
                                child: Text(
                                  widget.bet.status
                                      .stringAmount(widget.bet.amount),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    decoration:
                                        widget.bet.status == BetStatus.cancelled
                                            ? TextDecoration.lineThrough
                                            : null,
                                    fontSize:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? 12
                                            : 14,
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
                                    color: widget.bet.creator.teamId ==
                                            widget.bet.awayTeam.teamId
                                        ? widget.bet.creator.choice
                                            .color(context)
                                        : widget.bet.opponent != null
                                            ? widget.bet.opponent!.teamId ==
                                                    widget.bet.awayTeam.teamId
                                                ? widget.bet.opponent!.choice
                                                    .color(context)
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
                              height: ResponsiveWidget.isSmallScreen(context)
                                  ? 8
                                  : 12,
                            ),
                            Text(
                              widget.bet.awayTeam.name,
                              style: TextStyle(
                                color: context.colors.black,
                                fontWeight:
                                    ResponsiveWidget.isSmallScreen(context)
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                fontSize:
                                    ResponsiveWidget.isSmallScreen(context)
                                        ? 12
                                        : 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

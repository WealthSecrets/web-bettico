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
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';

import '/core/core.dart';

class P2PBettingHistoryCard extends StatefulWidget {
  const P2PBettingHistoryCard({
    Key? key,
    required this.betId,
    required this.isMyBets,
    this.onPressed,
  }) : super(key: key);

  final String betId;
  final bool isMyBets;
  final Function()? onPressed;

  @override
  State<P2PBettingHistoryCard> createState() => _P2PBettingHistoryCardState();
}

class _P2PBettingHistoryCardState extends State<P2PBettingHistoryCard> {
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();
  final P2PBetController p2pBetController = Get.find<P2PBetController>();

  Timer? _timer;
  String? winner;
  String? winnerWalletAddress;

  final StreamController<LiveScore?> _liveScoreStreamController =
      StreamController<LiveScore?>.broadcast();

  @override
  void initState() {
    super.initState();
    final Bet bet = p2pBetController.getBetById(widget.betId);
    winner = bet.winner?.id;
    if (bet.winner?.id == bet.creator.user.id) {
      winnerWalletAddress = bet.creator.wallet;
    } else if (bet.winner?.id == bet.opponent?.user.id) {
      winnerWalletAddress = bet.opponent?.wallet;
    }
    onOneTimeFetch(bet.competitionId);
    startBroadcast(bet.competitionId);
  }

  @override
  void dispose() {
    _liveScoreStreamController.close();
    _timer?.cancel();
    super.dispose();
  }

  void onOneTimeFetch(int fixtureId) async {
    final LiveScore? sFixture = await lController.getMatchSFixture(fixtureId);
    _liveScoreStreamController.add(sFixture);
  }

  void startBroadcast(int fixtureId) async {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
      final LiveScore? sFixture = await lController.getMatchSFixture(fixtureId);
      _liveScoreStreamController.add(sFixture);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final Bet bet =
          p2pBetController.getBetById(widget.betId, isMyBets: widget.isMyBets);

      print('Checking Bet: winner: ${bet.winner?.id}');

      // final Bet? bets = p2pBetController.bets.value
      //     .firstWhereOrNull((Bet b) => b.id == widget.betId);

      return StreamBuilder<LiveScore?>(
        stream: _liveScoreStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot<LiveScore?> snapshot) {
          final LiveScore? liveScoreData = snapshot.data;
          if (liveScoreData != null) {
            if (liveScoreData.time.status?.toLowerCase() == 'ft') {
              if ((bet.creator.teamId == liveScoreData.localTeamId) &&
                  (liveScoreData.scores!.localTeamScore >
                      liveScoreData.scores!.visitorTeamScore) &&
                  bet.creator.choice == BettorChoice.win) {
                winner = bet.creator.user.id;
                winnerWalletAddress = bet.creator.wallet;
              } else if ((bet.creator.teamId == liveScoreData.localTeamId) &&
                  (liveScoreData.scores!.localTeamScore <
                      liveScoreData.scores!.visitorTeamScore) &&
                  bet.creator.choice == BettorChoice.loss) {
                winner = bet.creator.user.id;
                winnerWalletAddress = bet.creator.wallet;
              } else if ((bet.opponent?.teamId == liveScoreData.localTeamId) &&
                  (liveScoreData.scores!.localTeamScore <
                      liveScoreData.scores!.visitorTeamScore) &&
                  bet.opponent?.choice == BettorChoice.loss) {
                winner = bet.opponent?.user.id;
                winnerWalletAddress = bet.opponent?.wallet;
              } else if ((bet.opponent?.teamId == liveScoreData.localTeamId) &&
                  (liveScoreData.scores!.localTeamScore >
                      liveScoreData.scores!.visitorTeamScore) &&
                  bet.opponent?.choice == BettorChoice.win) {
                winner = bet.opponent?.user.id;
                winnerWalletAddress = bet.opponent?.wallet;
              } else if (bet.creator.choice == BettorChoice.draw &&
                  (liveScoreData.scores!.localTeamScore ==
                      liveScoreData.scores!.visitorTeamScore)) {
                winner = bet.creator.user.id;
                winnerWalletAddress = bet.creator.wallet;
              } else if (bet.opponent?.choice == BettorChoice.draw &&
                  (liveScoreData.scores!.localTeamScore ==
                      liveScoreData.scores!.visitorTeamScore)) {
                winner = bet.opponent?.user.id;
                winnerWalletAddress = bet.opponent?.wallet;
              }
              p2pBetController.addStatusScoreToBet(
                betId: bet.id,
                score:
                    '${liveScoreData.scores!.localTeamScore} : ${liveScoreData.scores!.visitorTeamScore}',
                status: liveScoreData.time.status?.toLowerCase() ?? 'h1',
                winner: winner,
              );
            }
            p2pBetController.addStatusScoreToBet(
              betId: bet.id,
              score:
                  '${liveScoreData.scores!.localTeamScore} : ${liveScoreData.scores!.visitorTeamScore}',
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
                        if (bet.date != null &&
                            (liveScoreData != null &&
                                liveScoreData.time.status?.toLowerCase() ==
                                    'ns'))
                          TimeCard(dateTime: DateTime.parse(bet.date!)),
                        if (liveScoreData != null &&
                            liveScoreData.time.status?.toLowerCase() == 'live')
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
                              liveScoreData.time.status?.toLowerCase() == 'ns'
                                  ? 'NS'
                                  : liveScoreData.time.status?.toLowerCase() ==
                                          'live'
                                      ? '${liveScoreData.time.minute}\''
                                      : '${liveScoreData.time.status}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: context.colors.primary,
                              ),
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8)
                              .add(const EdgeInsets.symmetric(vertical: 4)),
                          decoration: BoxDecoration(
                            borderRadius: AppBorderRadius.largeAll,
                            color: bet.status.color(context).withOpacity(.3),
                            border: Border.all(
                              color: bet.status.color(context),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            bet.status.stringValue.toUpperCase(),
                            style: TextStyle(
                              fontSize: ResponsiveWidget.isSmallScreen(context)
                                  ? 8
                                  : 10,
                              // fontWeight: FontWeight.w700,
                              fontWeight:
                                  ResponsiveWidget.isSmallScreen(context)
                                      ? FontWeight.w700
                                      : FontWeight.normal,
                              color: bet.status.color(context),
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
                              if (bet.homeTeam.logo != null)
                                Container(
                                  height: 60,
                                  width: 60,
                                  padding: AppPaddings.lA,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: bet.creator.teamId ==
                                              bet.homeTeam.teamId
                                          ? bet.creator.choice.color(context)
                                          : bet.opponent != null
                                              ? bet.opponent!.teamId ==
                                                      bet.homeTeam.teamId
                                                  ? bet.opponent!.choice
                                                      .color(context)
                                                  : context.colors.text
                                              : context.colors.text,
                                      width: 2,
                                      style: BorderStyle.solid,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        bet.homeTeam.logo!,
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
                                bet.homeTeam.name,
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
                                    ? '${snapshot.data!.scores?.localTeamScore} - ${snapshot.data!.scores?.visitorTeamScore}'
                                    : bet.score ?? '? - ?',
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
                                    ? const EdgeInsets.symmetric(vertical: 4)
                                        .add(const EdgeInsets.symmetric(
                                            horizontal: 8))
                                    : const EdgeInsets.symmetric(vertical: 4)
                                        .add(const EdgeInsets.symmetric(
                                            horizontal: 16)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: bet.status.color(context),
                                ),
                                child: Center(
                                  child: Text(
                                    bet.status.stringAmount(bet.amount),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                          ResponsiveWidget.isSmallScreen(
                                                  context)
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      decoration:
                                          bet.status == BetStatus.cancelled
                                              ? TextDecoration.lineThrough
                                              : null,
                                      fontSize: ResponsiveWidget.isSmallScreen(
                                              context)
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
                              if (bet.awayTeam.logo != null)
                                Container(
                                  height: 60,
                                  width: 60,
                                  padding: AppPaddings.lA,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: bet.creator.teamId ==
                                              bet.awayTeam.teamId
                                          ? bet.creator.choice.color(context)
                                          : bet.opponent != null
                                              ? bet.opponent!.teamId ==
                                                      bet.awayTeam.teamId
                                                  ? bet.opponent!.choice
                                                      .color(context)
                                                  : context.colors.text
                                              : context.colors.text,
                                      width: 2,
                                      style: BorderStyle.solid,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        bet.awayTeam.logo!,
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
                                bet.awayTeam.name,
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
                    const SizedBox(height: 16),
                    if (bController.isYou(winner) && !(bet.payout ?? false))
                      AppConstrainedButton(
                        disabled:
                            bController.isYou(winner) && (bet.payout ?? false),
                        color: context.colors.success,
                        textColor: Colors.white,
                        selected: true,
                        text: 'Cashout',
                        onPressed: () async {
                          if (!lController.isConnected) {
                            if (Ethereum.isSupported) {
                              lController.initiateWalletConnect(
                                (String wallet) => cashout(
                                  context,
                                  winnerWalletAddress,
                                  bet,
                                  lController,
                                  p2pBetController,
                                ),
                              );
                            } else {
                              await lController.connectWC(
                                (_) => cashout(
                                  context,
                                  winnerWalletAddress,
                                  bet,
                                  lController,
                                  p2pBetController,
                                ),
                              );
                            }
                          } else {
                            cashout(
                              context,
                              winnerWalletAddress,
                              bet,
                              lController,
                              p2pBetController,
                            );
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
    });
  }
}

void cashout(BuildContext context, String? walletAddress, Bet bet,
    LiveScoreController lController, P2PBetController p2pBetController) async {
  if (walletAddress != null && !(bet.payout ?? false)) {
    lController.convertAmount(context, 'wsc', bet.amount * 2);

    final String? feedback = await lController.payout(
      context,
      walletAddress,
      lController.convertedAmount.value,
    );

    if (feedback != null) {
      p2pBetController.closePayout(
        betId: bet.id,
      );
    }
  } else {
    await AppSnacks.show(
      context,
      message: 'Cashout not allowed',
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

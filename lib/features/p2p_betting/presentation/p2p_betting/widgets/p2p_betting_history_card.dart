import 'dart:async';

import 'package:betticos/common/common.dart';
import 'package:betticos/controllers/controllers.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class P2PBettingHistoryCard extends StatefulWidget {
  const P2PBettingHistoryCard({
    super.key,
    required this.bet,
    required this.isMyBets,
    this.onPressed,
  });

  final Bet bet;
  final bool isMyBets;
  final Function()? onPressed;

  @override
  State<P2PBettingHistoryCard> createState() => _P2PBettingHistoryCardState();
}

class _P2PBettingHistoryCardState extends State<P2PBettingHistoryCard> {
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final WalletController wController = Get.find<WalletController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();
  final P2PBetController p2pBetController = Get.find<P2PBetController>();

  Timer? _timer;
  String? winner;
  String? winnerWalletAddress;
  Bet bet = Bet.empty();

  final StreamController<LiveScore?> _liveScoreStreamController = StreamController<LiveScore?>.broadcast();

  @override
  void initState() {
    super.initState();
    bet = widget.bet;
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
    return StreamBuilder<LiveScore?>(
      stream: _liveScoreStreamController.stream,
      builder: (BuildContext context, AsyncSnapshot<LiveScore?> snapshot) {
        final LiveScore? liveScoreData = snapshot.data;
        if (liveScoreData != null) {
          if (liveScoreData.time.status?.toLowerCase() == 'ft') {
            if ((bet.creator.teamId == liveScoreData.localTeamId) &&
                (liveScoreData.scores!.localTeamScore > liveScoreData.scores!.visitorTeamScore) &&
                bet.creator.choice == BettorChoice.win) {
              winner = bet.creator.user.id;
              winnerWalletAddress = bet.creator.wallet;
            } else if ((bet.creator.teamId == liveScoreData.localTeamId) &&
                (liveScoreData.scores!.localTeamScore < liveScoreData.scores!.visitorTeamScore) &&
                bet.creator.choice == BettorChoice.loss) {
              winner = bet.creator.user.id;
              winnerWalletAddress = bet.creator.wallet;
            } else if ((bet.opponent?.teamId == liveScoreData.localTeamId) &&
                (liveScoreData.scores!.localTeamScore < liveScoreData.scores!.visitorTeamScore) &&
                bet.opponent?.choice == BettorChoice.loss) {
              winner = bet.opponent?.user.id;
              winnerWalletAddress = bet.opponent?.wallet;
            } else if ((bet.opponent?.teamId == liveScoreData.localTeamId) &&
                (liveScoreData.scores!.localTeamScore > liveScoreData.scores!.visitorTeamScore) &&
                bet.opponent?.choice == BettorChoice.win) {
              winner = bet.opponent?.user.id;
              winnerWalletAddress = bet.opponent?.wallet;
            } else if (bet.creator.choice == BettorChoice.draw &&
                (liveScoreData.scores!.localTeamScore == liveScoreData.scores!.visitorTeamScore)) {
              winner = bet.creator.user.id;
              winnerWalletAddress = bet.creator.wallet;
            } else if (bet.opponent?.choice == BettorChoice.draw &&
                (liveScoreData.scores!.localTeamScore == liveScoreData.scores!.visitorTeamScore)) {
              winner = bet.opponent?.user.id;
              winnerWalletAddress = bet.opponent?.wallet;
            }
            p2pBetController.addStatusScoreToBet(
              betId: bet.id,
              score: '${liveScoreData.scores!.localTeamScore} : ${liveScoreData.scores!.visitorTeamScore}',
              status: 'completed',
              winner: winner,
            );
          } else {
            p2pBetController.addStatusScoreToBet(
              betId: bet.id,
              score: '${liveScoreData.scores!.localTeamScore} : ${liveScoreData.scores!.visitorTeamScore}',
              status: liveScoreData.time.status?.toLowerCase() ?? 'h1',
              winner: winner,
            );
          }
        }
        return Obx(
          () => AppLoadingBox(
            loading: (lController.isLoading.value && lController.closingBetID.contains(bet.id)) ||
                (lController.showLoadingLogo.value && lController.closingBetID.contains(bet.id)) ||
                (p2pBetController.isClosingPayout.value && p2pBetController.closingBetID.contains(bet.id)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 4).add(
                const EdgeInsets.only(top: 4),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: context.colors.cardColor),
                borderRadius: AppBorderRadius.smallAll,
              ),
              child: TextButton(
                style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                onPressed: widget.onPressed,
                child: Padding(
                  padding: ResponsiveWidget.isSmallScreen(context)
                      ? const EdgeInsets.symmetric(horizontal: 16)
                      : const EdgeInsets.symmetric(vertical: 16).add(const EdgeInsets.symmetric(horizontal: 38)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          if (bet.date != null &&
                              (liveScoreData != null && liveScoreData.time.status?.toLowerCase() == 'ns'))
                            TimeCard(dateTime: DateTime.parse(bet.date!)),
                          if (liveScoreData != null && liveScoreData.time.status?.toLowerCase() == 'live')
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: context.colors.primary.withOpacity(.2),
                                border: Border.all(color: context.colors.primary),
                              ),
                              child: Text(
                                liveScoreData.time.status?.toLowerCase() == 'ns'
                                    ? 'NS'
                                    : liveScoreData.time.status?.toLowerCase() == 'live'
                                        ? '${liveScoreData.time.minute}\''
                                        : '${liveScoreData.time.status}',
                                style:
                                    TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: context.colors.primary),
                              ),
                            ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8).add(const EdgeInsets.symmetric(vertical: 4)),
                            decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.largeAll,
                              color: bet.status.color(context).withOpacity(.3),
                              border: Border.all(color: bet.status.color(context)),
                            ),
                            child: Text(
                              bet.status.stringValue.toUpperCase(),
                              style: TextStyle(
                                fontSize: ResponsiveWidget.isSmallScreen(context) ? 8 : 10,
                                fontWeight:
                                    ResponsiveWidget.isSmallScreen(context) ? FontWeight.w700 : FontWeight.normal,
                                color: bet.status.color(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 8 : 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 130,
                            child: Column(
                              children: <Widget>[
                                if (bet.homeTeam.logo != null)
                                  Container(
                                    height: 60,
                                    width: 60,
                                    padding: AppPaddings.lA,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: bet.creator.teamId == bet.homeTeam.teamId
                                            ? bet.creator.choice.color(context)
                                            : bet.opponent != null
                                                ? bet.opponent!.teamId == bet.homeTeam.teamId
                                                    ? bet.opponent!.choice.color(context)
                                                    : context.colors.text
                                                : context.colors.text,
                                        width: 2,
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
                                SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 8 : 12),
                                Text(
                                  bet.homeTeam.name,
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
                                      : bet.score ?? '? - ?',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold, color: context.colors.text, fontSize: 24),
                                ),
                                SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 8 : 12),
                                Container(
                                  padding: ResponsiveWidget.isSmallScreen(context)
                                      ? const EdgeInsets.symmetric(vertical: 4)
                                          .add(const EdgeInsets.symmetric(horizontal: 8))
                                      : const EdgeInsets.symmetric(vertical: 4)
                                          .add(const EdgeInsets.symmetric(horizontal: 16)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: bet.status.color(context),
                                  ),
                                  child: Center(
                                    child: Text(
                                      bet.status.stringAmount(bet.amount),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: ResponsiveWidget.isSmallScreen(context)
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        decoration:
                                            bet.status == BetStatus.cancelled ? TextDecoration.lineThrough : null,
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
                              children: <Widget>[
                                if (bet.awayTeam.logo != null)
                                  Container(
                                    height: 60,
                                    width: 60,
                                    padding: AppPaddings.lA,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: bet.creator.teamId == bet.awayTeam.teamId
                                            ? bet.creator.choice.color(context)
                                            : bet.opponent != null
                                                ? bet.opponent!.teamId == bet.awayTeam.teamId
                                                    ? bet.opponent!.choice.color(context)
                                                    : context.colors.text
                                                : context.colors.text,
                                        width: 2,
                                      ),
                                      image:
                                          DecorationImage(image: NetworkImage(bet.awayTeam.logo!), fit: BoxFit.contain),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 8 : 12),
                                Text(
                                  bet.awayTeam.name,
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
                      if ((bet.status == BetStatus.completed || liveScoreData?.time.status?.toLowerCase() == 'ft') &&
                          bController.isYou(winner) &&
                          !(bet.payout ?? false))
                        AppConstrainedButton(
                          disabled: (bController.isYou(winner) && (bet.payout ?? false)) ||
                              (lController.showLoadingLogo.value && lController.closingBetID.contains(bet.id)) ||
                              p2pBetController.isClosingPayout.value,
                          color: context.colors.success,
                          textColor: Colors.white,
                          selected: true,
                          text: 'Cashout',
                          onPressed: () async {
                            if (!wController.isConnected) {
                              if (Ethereum.isSupported) {
                                wController.walletInit(
                                  (String wallet) => cashout(
                                    context,
                                    winnerWalletAddress,
                                    bet,
                                    wController,
                                    p2pBetController,
                                    widget.isMyBets,
                                  ),
                                );
                              } else {
                                wController.walletInit(
                                  (_) => cashout(
                                    context,
                                    winnerWalletAddress,
                                    bet,
                                    wController,
                                    p2pBetController,
                                    widget.isMyBets,
                                  ),
                                );
                              }
                            } else {
                              cashout(
                                context,
                                winnerWalletAddress,
                                bet,
                                wController,
                                p2pBetController,
                                widget.isMyBets,
                              );
                            }
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void cashout(
  BuildContext context,
  String? walletAddress,
  Bet bet,
  WalletController wController,
  P2PBetController p2pBetController,
  bool isMyBet,
) async {
  if (walletAddress != null && !(bet.payout ?? false)) {
    await AppSnacks.show(
      context,
      message: 'Cashout initiated, please wait...',
      duration: const Duration(milliseconds: 500),
      backgroundColor: context.colors.success,
      leadingIcon: const Icon(
        Ionicons.checkmark_done_sharp,
        color: Colors.white,
      ),
    );
    double theAmount = bet.amount;
    if (bet.opponent != null) {
      theAmount = bet.amount * 2;
    }
    if (context.mounted) {
      wController.convertAmount(
        context,
        'wsc',
        theAmount,
        betId: bet.id,
        successCallback: (double amount) async {
          final TransactionResponse? response = await wController.payout(
            context,
            walletAddress,
            wController.convertedAmount.value,
            bet.id,
          );
          if (response != null) {
            p2pBetController.closePayout(
              betId: bet.id,
              txthash: response.hash,
              isMyBets: isMyBet,
              callback: () {
                p2pBetController.createBetTransaction(
                  context,
                  convertedAmount: amount,
                  description: 'Bet Cashout',
                  type: 'withdrawal',
                  betId: bet.id,
                  amount: bet.amount,
                  wallet: wController.walletAddress.value,
                  txthash: response.hash,
                  convertedToken: wController.selectedCurrency.value,
                  time: response.timestamp,
                  callback: () => AppSnacks.show(
                    context,
                    message: 'Cashout successful.',
                    backgroundColor: context.colors.success,
                  ),
                );
              },
            );
          }
        },
        failureCallback: () => AppSnacks.show(
          context,
          message: 'Failed to cashout, try again later.',
        ),
      );
    }
  } else {
    await AppSnacks.show(
      context,
      message: 'Cashout not allowed!',
    );
  }
}

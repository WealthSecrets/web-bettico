import 'package:betticos/core/presentation/widgets/app_failure_screen.dart';
import 'package:betticos/features/p2p_betting/data/models/bet/bet.dart';
import 'package:betticos/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/score_row.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/p2p_betting_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/core/core.dart';

class P2PBettingSwiper extends StatefulWidget {
  const P2PBettingSwiper({
    Key? key,
  }) : super(key: key);

  @override
  _P2PBettingSwiperState createState() => _P2PBettingSwiperState();
}

class _P2PBettingSwiperState extends State<P2PBettingSwiper> {
  late final PageController _controller;

  final ValueNotifier<int> _activePageValueNotifier = ValueNotifier<int>(0);

  final P2PBetController _p2pBetController = Get.find<P2PBetController>();

  List<Bet> ongoingBets = <Bet>[];

  @override
  void initState() {
    //ScreenWidth minus padding(60)
    // _p2pBetController.getAllBets();
    final double fraction = (1.sw - 30) / 1.sw;
    _controller = PageController(
      viewportFraction: fraction,
    );
    ongoingBets = _p2pBetController.bets
        .where((Bet b) => b.status == BetStatus.ongoing)
        .toList();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _activePageValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ongoingBets.isNotEmpty
        ? SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 125,
                  child: PageView(
                    onPageChanged: (int index) =>
                        _activePageValueNotifier.value = index,
                    controller: _controller,
                    children: <Widget>[
                      ...ongoingBets.map(
                        (Bet b) => P2PBettingHistoryCard(
                          bet: b,
                        ),
                      ),
                    ],
                  ),
                ),
                const AppSpacing(v: 15),
                ValueListenableBuilder<int>(
                  valueListenable: _activePageValueNotifier,
                  builder: (_, int activePage, __) {
                    return PageViewIndicators(
                      activeItemIndex: activePage,
                      itemCount: ongoingBets.length,
                    );
                  },
                )
              ],
            ),
          )
        : SliverToBoxAdapter(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.ease,
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                margin: AppPaddings.lH.add(AppPaddings.sT),
                decoration: BoxDecoration(
                  color: context.colors.primary.shade50,
                  border: Border.all(
                    color: context.colors.primary.shade100,
                    width: 1,
                  ),
                  borderRadius: AppBorderRadius.card,
                ),
              ),
            ),
          );
  }
}

class P2POngoingCard extends StatelessWidget {
  P2POngoingCard({
    Key? key,
    required this.bet,
    this.backgroundColor,
  }) : super(key: key);
  final Bet bet;

  final Color? backgroundColor;
  final P2PBetController _p2pBetController = Get.find<P2PBetController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.sA,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.primary.shade100,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: AppPaddings.mH.add(AppPaddings.sV),
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
                  style: context.overline.copyWith(
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: bet.status.color(context),
                  ),
                ),
              ),
            ],
          ),
          const AppSpacing(v: 8),
          FutureBuilder<SoccerMatch?>(
            future: _p2pBetController.getLiveTeamMatch(
              context,
              bet.creator.teamId,
              bet.competitionId,
              bet.isFixture ?? false
                  ? bet.date!
                  : DateFormat('yyyy-MM-dd').format(bet.createdAt),
              isFixture: bet.isFixture,
            ),
            builder:
                (BuildContext context, AsyncSnapshot<SoccerMatch?> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data != null
                    ? ScoreRow(
                        awayName: snapshot.data!.awayName,
                        homeName: snapshot.data!.homeName,
                        score: snapshot.data!.score!,
                        time: snapshot.data!.time,
                      )
                    : const SizedBox.shrink();
              } else if (snapshot.hasError) {
                return AppFailureScreen(snapshot.error.toString());
              } else {
                return const Center(
                  child: LoadingLogo(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

// extension BetStatusX on BetStatus {
//   Color color(BuildContext context) {
//     switch (this) {
//       case BetStatus.awaiting:
//         return context.colors.yellow;
//       case BetStatus.ongoing:
//         return context.colors.success;
//       case BetStatus.won:
//         return context.colors.success;
//       case BetStatus.lost:
//         return context.colors.error;
//       case BetStatus.ignored:
//         return context.colors.textDark;
//     }
//   }
// }

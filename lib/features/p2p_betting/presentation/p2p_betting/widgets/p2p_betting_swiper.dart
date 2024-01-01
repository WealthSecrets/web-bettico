import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class P2PBettingSwiper extends StatefulWidget {
  const P2PBettingSwiper({super.key});

  @override
  State<P2PBettingSwiper> createState() => _P2PBettingSwiperState();
}

class _P2PBettingSwiperState extends State<P2PBettingSwiper> {
  late final PageController _controller;

  final ValueNotifier<int> _activePageValueNotifier = ValueNotifier<int>(0);

  final P2PBetController _p2pBetController = Get.find<P2PBetController>();

  List<Bet> ongoingBets = <Bet>[];

  @override
  void initState() {
    final double fraction = (1.sw - 30) / 1.sw;
    _controller = PageController(viewportFraction: fraction);
    ongoingBets = _p2pBetController.bets.where((Bet b) => b.status == BetStatus.ongoing).toList();
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
                    onPageChanged: (int index) => _activePageValueNotifier.value = index,
                    controller: _controller,
                    children: <Widget>[
                      ...ongoingBets.map(
                        (Bet b) => P2PBettingHistoryCard(bet: b, isMyBets: false),
                      ),
                    ],
                  ),
                ),
                const AppSpacing(v: 15),
                ValueListenableBuilder<int>(
                  valueListenable: _activePageValueNotifier,
                  builder: (_, int activePage, __) {
                    return PageViewIndicators(activeItemIndex: activePage, itemCount: ongoingBets.length);
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
                  border: Border.all(color: context.colors.primary.shade100),
                  borderRadius: AppBorderRadius.card,
                ),
              ),
            ),
          );
  }
}

class P2POngoingCard extends StatelessWidget {
  const P2POngoingCard({super.key, required this.bet, this.backgroundColor});

  final Bet bet;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.sA,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(color: backgroundColor ?? context.colors.primary.shade100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: AppPaddings.mH.add(AppPaddings.sV),
            decoration: BoxDecoration(
              borderRadius: AppBorderRadius.largeAll,
              color: bet.status.color(context).withOpacity(.3),
              border: Border.all(color: bet.status.color(context)),
            ),
            child: Text(
              bet.status.stringValue.toUpperCase(),
              style:
                  context.overline.copyWith(fontSize: 8, fontWeight: FontWeight.w700, color: bet.status.color(context)),
            ),
          ),
        ],
      ),
    );
  }
}

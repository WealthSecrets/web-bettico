import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '/core/core.dart';
import '../widgets/betting_modal.dart';
import '../widgets/p2p_betting_app_bar.dart';
import '../widgets/p2p_betting_filter_bar.dart';
import '../widgets/p2p_betting_history_card.dart';
// import '../widgets/p2p_betting_swiper.dart';

class P2PBettingHistoryScreen extends StatefulWidget {
  const P2PBettingHistoryScreen({Key? key}) : super(key: key);
  static const String route = 'P2PBettingHistoryScreen';

  @override
  _P2PBettingHistoryScreenState createState() =>
      _P2PBettingHistoryScreenState();
}

class _P2PBettingHistoryScreenState extends State<P2PBettingHistoryScreen> {
  // getx controllers
  final P2PBetController _p2pBetController = Get.find<P2PBetController>();

  @override
  void initState() {
    _p2pBetController.getMyBets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (_, __) {
          return <Widget>[
            const P2PBettingAppBar(),
            // const SliverToBoxAdapter(child: AppSpacing(v: 10)),
            // const P2PBettingSwiper(),
            const P2PBettingFilterBar(),
          ];
        },
        body: Obx(
          () => AppLoadingBox(
            loading: _p2pBetController.isFetchingMyBets.value,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: AppPaddings.homeH,
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, int index) {
                        if (_p2pBetController.myBets.isNotEmpty) {
                          return P2PBettingHistoryCard(
                            key: ObjectKey(
                              _p2pBetController.myBets[index].id,
                            ),
                            bet: _p2pBetController.myBets[index],
                            onPressed: () async {
                              await showMaterialModalBottomSheet<bool?>(
                                bounce: true,
                                useRootNavigator: true,
                                animationCurve: Curves.fastLinearToSlowEaseIn,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                  ),
                                ),
                                builder: (BuildContext modalContext) {
                                  return P2PBettingBottomSheet(
                                    bet: _p2pBetController.myBets[index],
                                  );
                                },
                                context: context,
                              );
                            },
                          );
                        }
                        return Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          margin: AppPaddings.sV.add(AppPaddings.sT),
                          decoration: BoxDecoration(
                            color: context.colors.primary.shade50,
                            border: Border.all(
                              color: context.colors.primary.shade100,
                              width: 1,
                            ),
                            borderRadius: AppBorderRadius.card,
                          ),
                          child: const AppEmptyScreen(
                            message: 'All bets will show up here.',
                          ),
                        );
                      },
                      childCount: _p2pBetController.myBets.length,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

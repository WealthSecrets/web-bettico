import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class P2PBettingHistoryScreen extends StatefulWidget {
  const P2PBettingHistoryScreen({super.key});
  static const String route = 'P2PBettingHistoryScreen';

  @override
  State<P2PBettingHistoryScreen> createState() => _P2PBettingHistoryScreenState();
}

class _P2PBettingHistoryScreenState extends State<P2PBettingHistoryScreen> {
  final P2PBetController _p2pBetController = Get.find<P2PBetController>();

  @override
  void initState() {
    _p2pBetController.getMyBets(_p2pBetController.filterStatus.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (_, __) {
          return <Widget>[const P2PBettingAppBar(), P2PBettingFilterBar()];
        },
        body: Obx(
          () => AppLoadingBox(
            loading: _p2pBetController.isFetchingMyBets.value,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: AppPaddings.lH,
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, int index) {
                        if (_p2pBetController.myBets.isNotEmpty) {
                          return P2PBettingHistoryCard(
                            key: ObjectKey(
                              _p2pBetController.myBets[index].id,
                            ),
                            bet: _p2pBetController.myBets[index],
                            isMyBets: true,
                            onPressed: () async {
                              await showMaterialModalBottomSheet<bool?>(
                                bounce: true,
                                useRootNavigator: true,
                                animationCurve: Curves.fastLinearToSlowEaseIn,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                                ),
                                builder: (BuildContext modalContext) {
                                  return P2PBettingBottomSheet(bet: _p2pBetController.myBets[index]);
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
                            border: Border.all(color: context.colors.primary.shade100),
                            borderRadius: AppBorderRadius.card,
                          ),
                          child: const AppEmptyScreen(message: 'All bets will show up here.'),
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

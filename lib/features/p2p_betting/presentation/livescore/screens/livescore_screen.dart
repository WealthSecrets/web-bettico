import 'package:betticos/core/presentation/helpers/responsiveness.dart';
// import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
// import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '../../../../betticos/presentation/base/getx/base_screen_controller.dart';
import '../widgets/livescore_app_bar.dart';
import '../widgets/score_row.dart';

// ignore: must_be_immutable
class LiveScoreScreen extends StatefulWidget {
  const LiveScoreScreen({Key? key}) : super(key: key);
  @override
  State<LiveScoreScreen> createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();
  final P2PBetController _p2pBetController = Get.find<P2PBetController>();

  @override
  void initState() {
    super.initState();
    _p2pBetController.getMyBets(_p2pBetController.filterStatus.value);
    WidgetUtils.onWidgetDidBuild(() {
      lController.initiateWalletConnect();
      lController.getAllLiveMatches(context);
      lController.getAllFixtures(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (_, __) {
          return <Widget>[
            Obx(
              () => LiveScoreAppBar(
                onMenuPressed: () {},
                onChanged: (String text) {},
                walletAddress: lController.walletAddress.value,
                onPressed: () async {
                  if (lController.walletAddress.isNotEmpty) {
                    showDeleteConnectionDialogue(context);
                  } else {
                    if (Ethereum.isSupported) {
                      lController.initiateWalletConnect();
                    } else {
                      await lController.connectWC();
                    }
                  }
                },
              ),
            ),
          ];
        },
        body: Obx(
          () {
            return AppLoadingBox(
              loading: lController.isLoading.value,
              child: CustomScrollView(
                slivers: <Widget>[
                  if (lController.matches.isEmpty &&
                      lController.fixtures.isEmpty &&
                      !lController.isLoading.value)
                    SliverFillRemaining(
                      child: Padding(
                        padding: AppPaddings.bodyH,
                        child: AppAnimatedColumn(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const AppSpacing(v: 30),
                            SvgPicture.asset(
                              AssetSVGs.emptyState.path,
                              height: 100,
                            ),
                            const AppSpacing(v: 10),
                            Text(
                              'Nothing to See Here',
                              style: TextStyle(
                                color: context.colors.textDark,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            const AppSpacing(v: 10),
                            Text(
                              'All fixtures and live matches will show up here',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.colors.text,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (lController.fixtures.isNotEmpty)
                    SliverPadding(
                      padding: AppPaddings.lH,
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, int index) {
                            if (index == 0) {
                              return Padding(
                                padding: AppPaddings.mV,
                                child: Text(
                                  'Fixtures',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? 12
                                            : 14,
                                  ),
                                ),
                              );
                            }
                            return Container(
                              margin: AppPaddings.sV.add(AppPaddings.sT),
                              child: InkWell(
                                onTap: () async {
                                  if (!lController.isConnected) {
                                    if (Ethereum.isSupported) {
                                      lController.initiateWalletConnect();
                                    } else {
                                      await lController.connectWC();
                                    }
                                  } else {
                                    // final Fixture fixture =
                                    //     lController.fixtures[index - 1];

                                    // await Navigator.of(context).push<void>(
                                    //   MaterialPageRoute<void>(
                                    //     builder: (BuildContext context) =>
                                    //         P2PBettingScreen(
                                    //       fixture: fixture,
                                    //     ),
                                    //   ),
                                    // );
                                  }
                                },
                                child: Container(
                                  padding: AppPaddings.lV,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: AppBorderRadius.smallAll,
                                    border: Border.all(
                                      color: context.colors.cardColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: ScoreRow(
                                    awayName: lController
                                        .fixtures[index - 1].awayName,
                                    homeName: lController
                                        .fixtures[index - 1].homeName,
                                    score: '? - ?',
                                    time: lController.fixtures[index - 1].time,
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: lController.fixtures.length + 1,
                        ),
                      ),
                    ),
                  if (lController.matches.isNotEmpty)
                    SliverPadding(
                      padding: AppPaddings.lH,
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, int index) {
                            if (index == 0) {
                              return Padding(
                                padding: AppPaddings.mV,
                                child: Text(
                                  'Live Matches',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? 12
                                            : 14,
                                  ),
                                ),
                              );
                            }
                            return Container(
                              margin: AppPaddings.sV.add(AppPaddings.sT),
                              child: InkWell(
                                onTap: () async {
                                  if (!lController.isConnected) {
                                    if (Ethereum.isSupported) {
                                      lController.initiateWalletConnect();
                                    } else {
                                      await lController.connectWC();
                                    }
                                  } else {
                                    final SoccerMatch match =
                                        lController.matches[index - 1];
                                    if (match.time.contains('FT') ||
                                        match.status == 'FINISHED') {
                                      await AppSnacks.show(
                                        context,
                                        message:
                                            'Can\'t bet on this match. It is already completed.',
                                        backgroundColor: context.colors.error,
                                        leadingIcon: const Icon(
                                          Ionicons.checkmark_circle_outline,
                                          color: Colors.white,
                                        ),
                                      );
                                    } else {
                                      // await Navigator.of(context).push<void>(
                                      //   MaterialPageRoute<void>(
                                      //     builder: (BuildContext context) =>
                                      //         P2PBettingScreen(
                                      //       match: match,
                                      //     ),
                                      //   ),
                                      // );
                                    }
                                  }
                                },
                                child: Container(
                                  padding: AppPaddings.lV,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: AppBorderRadius.smallAll,
                                    border: Border.all(
                                      color: context.colors.cardColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: ScoreRow(
                                    awayName:
                                        lController.matches[index - 1].awayName,
                                    homeName:
                                        lController.matches[index - 1].homeName,
                                    score:
                                        lController.matches[index - 1].score!,
                                    time: lController.matches[index - 1].time,
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: lController.matches.length + 1,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void showDeleteConnectionDialogue(
    BuildContext context, {
    String? title,
    Icon? icon,
  }) {
    showAppModal<void>(
      context: context,
      alignment: Alignment.center,
      builder: (BuildContext context) => AppOptionDialogueModal(
        modalContext: context,
        title: 'Disconnect Wallet',
        backgroundColor: context.colors.error,
        message:
            'This will disconnect your wallet address from Bettico. Are you sure you want to disconnect wallet?',
        affirmButtonText: 'Disconnect'.toUpperCase(),
        onPressed: () async {
          lController.disconnect();
          Get.back<void>();
        },
      ),
    );
  }
}

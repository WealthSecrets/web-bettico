import 'dart:async';

import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/fixture_card.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/livescore_card.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/new_livescore_app_bar.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/vertical_league_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../betticos/presentation/base/getx/base_screen_controller.dart';
import '../../p2p_betting/screens/p2p_betting_screen.dart';
import '../getx/live_score_controllers.dart';

class NewLiveScore extends KFDrawerContent {
  NewLiveScore({Key? key}) : super(key: key);

  @override
  State<NewLiveScore> createState() => _NewLiveScoreState();
}

class _NewLiveScoreState extends State<NewLiveScore> {
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  Map<String, StreamController<LiveScore>> liveScoreStreamControllers =
      <String, StreamController<LiveScore>>{};

  late final Timer _timer;

  @override
  void initState() {
    lController.getAllLeagues();
    _timer = Timer.periodic(const Duration(seconds: 60), (_) {
      lController.getLiveScores();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Obx(
            () => NewLiveScoreAppBar(
              onMenuPressed: widget.onMenuPressed,
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
          const SizedBox(height: 16),
          SizedBox(
            height: 146,
            child: Obx(
              () => lController.isFetchingLeagues.value
                  ? const Center(
                      child: LoadingLogo(),
                    )
                  : Column(
                      children: <Widget>[
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Leagues',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 112,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 28,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Obx(
                                () => VerticalLeagueCard(
                                  name: lController.sLeagues[index].name,
                                  imagePath: lController.sLeagues[index].logo,
                                  isSelected:
                                      lController.selectedLeague.value ==
                                          lController.sLeagues[index],
                                  onTap: () {
                                    lController.setSelectedLeague(
                                        lController.sLeagues[index]);
                                  },
                                ),
                              );
                            },
                            itemCount: lController.sLeagues.length,
                          ),
                        )
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Live Matches',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // SizedBox(
                  //   height: 220,
                  //   child: PagedListView<int, LiveScore>.separated(
                  //     pagingController: lController.pagingController.value,
                  //     padding:
                  //         const EdgeInsets.only(top: 20, bottom: 20, left: 20),
                  //     scrollDirection: Axis.horizontal,
                  //     builderDelegate: PagedChildBuilderDelegate<LiveScore>(
                  //       itemBuilder: (BuildContext context, LiveScore liveScore,
                  //           int index) {
                  //         return LiveScoreCard(
                  //           liveScore: liveScore,
                  //           onTap: () async {
                  //             if (!lController.isConnected) {
                  //               if (Ethereum.isSupported) {
                  //                 lController.initiateWalletConnect();
                  //               } else {
                  //                 await lController.connectWC();
                  //               }
                  //             } else {
                  //               if (liveScore.time.status == 'FT') {
                  //                 await AppSnacks.show(
                  //                   context,
                  //                   message:
                  //                       'Can\'t bet on this match. It is already completed.',
                  //                   backgroundColor: context.colors.error,
                  //                   leadingIcon: const Icon(
                  //                     Ionicons.checkmark_circle_outline,
                  //                     color: Colors.white,
                  //                   ),
                  //                 );
                  //               } else {
                  //                 await Navigator.of(context).push<void>(
                  //                   MaterialPageRoute<void>(
                  //                     builder: (BuildContext context) =>
                  //                         P2PBettingScreen(
                  //                       liveScore: liveScore,
                  //                     ),
                  //                   ),
                  //                 );
                  //               }
                  //             }
                  //           },
                  //         );
                  //       },
                  //       firstPageErrorIndicatorBuilder:
                  //           (BuildContext context) => ErrorIndicator(
                  //         error: lController.pagingController.value.error
                  //             as Failure,
                  //         onTryAgain: () =>
                  //             lController.pagingController.value.refresh(),
                  //       ),
                  //       noItemsFoundIndicatorBuilder: (BuildContext context) =>
                  //           EmptyListIndicator(
                  //         title: 'Nothing Found',
                  //         message:
                  //             'No livescores were found for this ${lController.selectedLeague.value.name}.',
                  //         size: 50,
                  //         gap: 16,
                  //         spacing: 8,
                  //       ),
                  //       newPageProgressIndicatorBuilder:
                  //           (BuildContext context) => const Center(
                  //         child: LoadingLogo(),
                  //       ),
                  //       firstPageProgressIndicatorBuilder:
                  //           (BuildContext context) => const Center(
                  //         child: LoadingLogo(),
                  //       ),
                  //       // padding: AppPaddings.homeA,
                  //     ),
                  //     separatorBuilder: (BuildContext context, int index) =>
                  //         const SizedBox.shrink(),
                  //   ),
                  // ),
                  Obx(
                    () => SizedBox(
                      height: 220,
                      child: lController.liveScores.isEmpty
                          ? const AppEmptyScreen(
                              message:
                                  'No Livescores were found for the selected league.')
                          : ListView.builder(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, left: 20),
                              scrollDirection: Axis.horizontal,
                              itemCount: lController.liveScores.length >= 10
                                  ? lController.liveScores.take(10).length
                                  : lController.liveScores.length,
                              itemBuilder: (BuildContext context, int index) {
                                final LiveScore liveScore =
                                    lController.liveScores[index];
                                return LiveScoreCard(
                                  liveScore: liveScore,
                                  onTap: () async {
                                    if (!lController.isConnected) {
                                      if (Ethereum.isSupported) {
                                        lController.initiateWalletConnect();
                                      } else {
                                        await lController.connectWC();
                                      }
                                    } else {
                                      if (liveScore.time.status == 'FT') {
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
                                        await Navigator.of(context).push<void>(
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                P2PBettingScreen(
                                              liveScore: liveScore,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Fixtures',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // SizedBox(
                  //   height: 125,
                  //   child: PagedListView<int, SFixture>.separated(
                  //     pagingController:
                  //         lController.fixturePagingController.value,
                  //     padding:
                  //         const EdgeInsets.only(top: 20, bottom: 20, left: 20),
                  //     scrollDirection: Axis.vertical,
                  //     builderDelegate: PagedChildBuilderDelegate<SFixture>(
                  //       itemBuilder: (BuildContext context, SFixture sFixture,
                  //           int index) {
                  //         return FixtureCard(sFixture: sFixture);
                  //       },
                  //       firstPageErrorIndicatorBuilder:
                  //           (BuildContext context) => ErrorIndicator(
                  //         error: lController.fixturePagingController.value.error
                  //             as Failure,
                  //         onTryAgain: () => lController
                  //             .fixturePagingController.value
                  //             .refresh(),
                  //       ),
                  //       noItemsFoundIndicatorBuilder: (BuildContext context) =>
                  //           const EmptyListIndicator(
                  //         title: 'Nothing Found',
                  //         message: 'No fixtures were found for this league.',
                  //         size: 50,
                  //         gap: 16,
                  //         spacing: 8,
                  //       ),
                  //       newPageProgressIndicatorBuilder:
                  //           (BuildContext context) => const Center(
                  //         child: LoadingLogo(),
                  //       ),
                  //       firstPageProgressIndicatorBuilder:
                  //           (BuildContext context) => const Center(
                  //         child: LoadingLogo(),
                  //       ),
                  //       // padding: AppPaddings.homeA,
                  //     ),
                  //     separatorBuilder: (BuildContext context, int index) =>
                  //         const SizedBox.shrink(),
                  //   ),
                  // ),
                  Obx(
                    () => lController.sFixtures.isEmpty
                        ? const AppEmptyScreen(
                            message:
                                'No fixtures were found for the selected league.')
                        : lController.isFetchingFixtures.value
                            ? const Center(
                                child: LoadingLogo(),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20),
                                child: Column(
                                  children: lController.sFixtures
                                      .map(
                                        (LiveScore f) => FixtureCard(
                                          sFixture: f,
                                          onTap: () async {
                                            if (!lController.isConnected) {
                                              if (Ethereum.isSupported) {
                                                lController
                                                    .initiateWalletConnect();
                                              } else {
                                                await lController.connectWC();
                                              }
                                            } else {
                                              if (f.time.status == 'FT') {
                                                await AppSnacks.show(
                                                  context,
                                                  message:
                                                      'Can\'t bet on this match. It is already completed.',
                                                  backgroundColor:
                                                      context.colors.error,
                                                  leadingIcon: const Icon(
                                                    Ionicons
                                                        .checkmark_circle_outline,
                                                    color: Colors.white,
                                                  ),
                                                );
                                              } else {
                                                await Navigator.of(context)
                                                    .push<void>(
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        P2PBettingScreen(
                                                      liveScore: f,
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                  ),
                ],
              ),
            ),
          )
        ],
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

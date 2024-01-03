import 'dart:async';

import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/controllers/controllers.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class NewLiveScore extends StatefulWidget {
  const NewLiveScore({super.key});

  @override
  State<NewLiveScore> createState() => _NewLiveScoreState();
}

class _NewLiveScoreState extends State<NewLiveScore> {
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final WalletController wController = Get.find<WalletController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  Map<String, StreamController<LiveScore>> liveScoreStreamControllers = <String, StreamController<LiveScore>>{};

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
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const AppSpacing(v: 30),
          Obx(
            () => NewLiveScoreAppBar(
              onMenuPressed: () {},
              onChanged: (String text) {},
              walletAddress: lController.walletAddress.value,
              onPressed: () async {
                if (lController.walletAddress.isNotEmpty) {
                  WidgetUtils.showDeleteConnectionDialogue(
                    context,
                    onPressed: () async {
                      wController.disconnect();
                      Get.back<void>();
                    },
                  );
                } else {
                  wController.walletInit();
                }
              },
              actions: <Widget>[
                IconButton(
                  icon: Image.asset(AssetImages.transactionHisotry, color: Colors.black, height: 24, width: 24),
                  onPressed: () => navigationController.navigateTo(AppRoutes.transactions),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 146,
            child: Obx(
              () => lController.isFetchingLeagues.value
                  ? const Center(child: LoadingLogo())
                  : Column(
                      children: <Widget>[
                        const SizedBox(height: 6),
                        Padding(
                          padding: isSmallScreen ? AppPaddings.lL : EdgeInsets.zero,
                          child: const Text(
                            'Leagues',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 112,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Obx(
                                () => VerticalLeagueCard(
                                  name: lController.sLeagues[index].name,
                                  imagePath: lController.sLeagues[index].logo,
                                  isSelected: lController.selectedLeague.value == lController.sLeagues[index],
                                  onTap: () {
                                    lController.setSelectedLeague(lController.sLeagues[index]);
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: isSmallScreen ? AppPaddings.lL : EdgeInsets.zero,
                      child: const Text(
                        'Live Matches',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => SizedBox(
                      height: 220,
                      child: lController.isFetchingLiveScores.value
                          ? const Center(child: LoadingLogo())
                          : lController.liveScores.isEmpty
                              ? const AppEmptyScreen(message: 'No Livescores were found for the selected league.')
                              : ListView.builder(
                                  padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: lController.liveScores.length >= 10
                                      ? lController.liveScores.take(10).length
                                      : lController.liveScores.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final LiveScore liveScore = lController.liveScores[index];

                                    return LiveScoreCard(
                                      liveScore: liveScore,
                                      onTap: () async => onMatchCardTapped(liveScore),
                                    );
                                  },
                                ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: isSmallScreen ? AppPaddings.lL : EdgeInsets.zero,
                      child: const Text(
                        'Fixtures',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => lController.sFixtures.isEmpty
                        ? const AppEmptyScreen(message: 'No fixtures were found for the selected league.')
                        : lController.isFetchingFixtures.value
                            ? const Center(child: LoadingLogo())
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                                child: Column(
                                  children: lController.sFixtures
                                      .map(
                                        (LiveScore liveScore) => FixtureCard(
                                          sFixture: liveScore,
                                          onTap: () async => onMatchCardTapped(liveScore),
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

  void onMatchCardTapped(LiveScore liveScore) async {
    final int? minutes = liveScore.time.minute;
    final int? localTeamScore = liveScore.scores?.localTeamScore;
    final int? visitorTeamScore = liveScore.scores?.visitorTeamScore;
    if (liveScore.time.status?.toLowerCase() == 'ft') {
      await AppSnacks.show(
        context,
        message: 'Sorry, match is already completed',
        backgroundColor: context.colors.error,
        leadingIcon: const Icon(Ionicons.checkmark_circle_outline, color: Colors.white),
      );
    } else if (minutes != null && minutes > 10) {
      await AppSnacks.show(
        context,
        message: 'Sorry, match has already started',
        backgroundColor: context.colors.error,
        leadingIcon: const Icon(Ionicons.checkmark_circle_outline, color: Colors.white),
      );
    } else if ((localTeamScore != null && localTeamScore > 0) || (visitorTeamScore != null && visitorTeamScore > 0)) {
      await AppSnacks.show(
        context,
        message: 'Can\'t bet on match when there is already a goal.',
        backgroundColor: context.colors.error,
        leadingIcon: const Icon(Ionicons.checkmark_circle_outline, color: Colors.white),
      );
    } else {
      if (!wController.isConnected) {
        if (Ethereum.isSupported) {
          wController.walletInit(
            (_) async => Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => P2PBettingScreen(liveScore: liveScore),
              ),
            ),
          );
        } else {
          wController.walletInit(
            (_) async => Navigator.of(context).push<void>(
              MaterialPageRoute<void>(builder: (BuildContext context) => P2PBettingScreen(liveScore: liveScore)),
            ),
          );
        }
      } else {
        await Navigator.of(context).push<void>(
          MaterialPageRoute<void>(builder: (BuildContext context) => P2PBettingScreen(liveScore: liveScore)),
        );
      }
    }
  }
}

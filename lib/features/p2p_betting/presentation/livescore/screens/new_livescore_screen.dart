import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/fixture_card.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/livescore_card.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/vertical_league_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../betticos/presentation/base/getx/base_screen_controller.dart';
import '../getx/live_score_controllers.dart';

class NewLiveScore extends KFDrawerContent {
  NewLiveScore({Key? key}) : super(key: key);

  @override
  State<NewLiveScore> createState() => _NewLiveScoreState();
}

class _NewLiveScoreState extends State<NewLiveScore> {
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  void initState() {
    super.initState();
    lController.getAllLeagues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
                          children: <Widget>[
                            const Text(
                              'Leagues',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            if (lController.sLeagues.length >= 10)
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'More',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: context.colors.primary,
                                  ),
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
                            itemCount: lController.sLeagues.length >= 10
                                ? lController.sLeagues.take(10).length
                                : lController.sLeagues.length,
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
                  SizedBox(
                    height: 220,
                    child: PagedListView<int, LiveScore>.separated(
                      pagingController: lController.pagingController.value,
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 20, left: 20),
                      scrollDirection: Axis.horizontal,
                      builderDelegate: PagedChildBuilderDelegate<LiveScore>(
                        itemBuilder: (BuildContext context, LiveScore liveScore,
                            int index) {
                          return LiveScoreCard(liveScore: liveScore);
                        },
                        firstPageErrorIndicatorBuilder:
                            (BuildContext context) => ErrorIndicator(
                          error: lController.pagingController.value.error
                              as Failure,
                          onTryAgain: () =>
                              lController.pagingController.value.refresh(),
                        ),
                        noItemsFoundIndicatorBuilder: (BuildContext context) =>
                            const EmptyListIndicator(
                          title: 'Nothing Found',
                          message: 'No livescores were found for this league.',
                          size: 50,
                          gap: 16,
                          spacing: 8,
                        ),
                        newPageProgressIndicatorBuilder:
                            (BuildContext context) => const Center(
                          child: LoadingLogo(),
                        ),
                        firstPageProgressIndicatorBuilder:
                            (BuildContext context) => const Center(
                          child: LoadingLogo(),
                        ),
                        // padding: AppPaddings.homeA,
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox.shrink(),
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
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 125,
                    child: PagedListView<int, SFixture>.separated(
                      pagingController:
                          lController.fixturePagingController.value,
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 20, left: 20),
                      scrollDirection: Axis.vertical,
                      builderDelegate: PagedChildBuilderDelegate<SFixture>(
                        itemBuilder: (BuildContext context, SFixture sFixture,
                            int index) {
                          return FixtureCard(sFixture: sFixture);
                        },
                        firstPageErrorIndicatorBuilder:
                            (BuildContext context) => ErrorIndicator(
                          error: lController.fixturePagingController.value.error
                              as Failure,
                          onTryAgain: () => lController
                              .fixturePagingController.value
                              .refresh(),
                        ),
                        noItemsFoundIndicatorBuilder: (BuildContext context) =>
                            const EmptyListIndicator(
                          title: 'Nothing Found',
                          message: 'No fixtures were found for this league.',
                          size: 50,
                          gap: 16,
                          spacing: 8,
                        ),
                        newPageProgressIndicatorBuilder:
                            (BuildContext context) => const Center(
                          child: LoadingLogo(),
                        ),
                        firstPageProgressIndicatorBuilder:
                            (BuildContext context) => const Center(
                          child: LoadingLogo(),
                        ),
                        // padding: AppPaddings.homeA,
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox.shrink(),
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
}

// import 'package:betticos/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
// import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/arguments/livescore_arguments.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';

import '../widgets/livescore_app_bar.dart';
import '../widgets/score_row.dart';

// ignore: must_be_immutable
class LiveScoreScreen extends KFDrawerContent {
  LiveScoreScreen({Key? key}) : super(key: key);
  @override
  State<LiveScoreScreen> createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  final LiveScoreController lController = Get.find<LiveScoreController>();

  @override
  void initState() {
    super.initState();
    WidgetUtils.onWidgetDidBuild(() {
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
            LiveScoreAppBar(
              onPressed: widget.onMenuPressed,
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
                                onTap: () {
                                  final Fixture fixture =
                                      lController.fixtures[index - 1];
                                  Get.toNamed<void>(
                                    AppRoutes.p2pBetting,
                                    arguments: LiveScoreArguments(
                                      fixture: fixture,
                                    ),
                                  );
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
                                onTap: () {
                                  final SoccerMatch match =
                                      lController.matches[index - 1];
                                  if (match.time.contains('FT') ||
                                      match.status == 'FINISHED') {
                                    AppSnacks.show(
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
                                    Get.toNamed<void>(
                                      AppRoutes.p2pBetting,
                                      arguments: LiveScoreArguments(
                                        match: match,
                                      ),
                                    );
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
}

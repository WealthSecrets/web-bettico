import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '../arguments/livescore_arguments.dart';
import 'score_row.dart';

class LivescoreSearchDelegate extends SearchDelegate<String> {
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  final LiveScoreController lController = Get.find<LiveScoreController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _debouncer.run(() {
      if (query.isNotEmpty) {
        lController.searchLiveMatchesAndFixtures(query);
      }
    });

    return Obx(() {
      return ListView.builder(
        itemCount: query.isNotEmpty
            ? lController.sMatches.isNotEmpty
                ? lController.sMatches.length
                : lController.sFixtures.length
            : lController.matches.isNotEmpty
                ? lController.matches.length
                : lController.fixtures.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildSearchCard(
            context,
            query.isNotEmpty
                ? lController.sMatches.isNotEmpty
                    ? lController.sMatches[index]
                    : lController.sFixtures[index]
                : lController.matches.isNotEmpty
                    ? lController.matches[index]
                    : lController.fixtures[index],
          );
        },
      );
    });
  }

  Widget _buildSearchCard(BuildContext context, dynamic match) {
    return Container(
      margin: AppPaddings.sV.add(AppPaddings.sT),
      child: InkWell(
        onTap: () {
          if ((match.time as String).contains('FT') ||
              match.status == 'FINISHED') {
            AppSnacks.show(
              context,
              message: 'Can\'t bet on this match. It is already completed.',
              backgroundColor: context.colors.error,
              leadingIcon: const Icon(
                Ionicons.checkmark_circle_outline,
                color: Colors.white,
              ),
            );
          } else {
            if (lController.sMatches.isNotEmpty) {
              Get.toNamed<void>(
                P2PBettingScreen.route,
                arguments: LiveScoreArguments(
                  match: match as SoccerMatch,
                ),
              );
            } else {
              Get.toNamed<void>(
                P2PBettingScreen.route,
                arguments: LiveScoreArguments(
                  fixture: match as Fixture,
                ),
              );
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
            awayName: match.awayName as String,
            homeName: match.homeName as String,
            score: match.score! as String,
            time: match.time as String,
          ),
        ),
      ),
    );
  }
}

import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class LiveScoreCard extends StatelessWidget {
  LiveScoreCard({Key? key, required this.liveScore}) : super(key: key);

  final LiveScoreController liveScoreController =
      Get.find<LiveScoreController>();

  final LiveScore liveScore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(
        right: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: Color.fromRGBO(69, 52, 127, 0.3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            Obx(
              () => Text(
                liveScoreController.selectedLeague.value.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FutureBuilder<Team?>(
                    future:
                        liveScoreController.getMatchTeam(liveScore.localTeamId),
                    builder:
                        (BuildContext context, AsyncSnapshot<Team?> value) {
                      if (value.hasData) {
                        final Team? team = value.data;
                        if (team != null) {
                          return _buildLiveScoreCard(
                            imagePath: team.logo,
                            name: team.name,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else {
                        return const LoadingLogo();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          liveScore.scores != null
                              ? liveScore.scores!.localTeamScore.toString()
                              : '0',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          ':',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          liveScore.scores != null
                              ? liveScore.scores!.localTeamScore.toString()
                              : '0',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: context.colors.primary.withOpacity(.2),
                        border: Border.all(
                          color: context.colors.primary,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Text(
                        '83\'',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: context.colors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: FutureBuilder<Team?>(
                    future: liveScoreController
                        .getMatchTeam(liveScore.visitorTeamId),
                    builder:
                        (BuildContext context, AsyncSnapshot<Team?> value) {
                      if (value.hasData) {
                        final Team? team = value.data;
                        if (team != null) {
                          return _buildLiveScoreCard(
                            imagePath: team.logo,
                            name: StringUtils.capitalizeFirst(
                              team.name,
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else {
                        return const LoadingLogo();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveScoreCard({
    required String imagePath,
    required String name,
  }) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 80,
          width: 80,
          child: Image.network(
            imagePath,
            height: 80,
            width: 80,
          ),
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

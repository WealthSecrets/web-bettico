import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/time_card.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FixtureCard extends StatelessWidget {
  FixtureCard({Key? key, required this.sFixture}) : super(key: key);

  final LiveScoreController liveScoreController =
      Get.find<LiveScoreController>();

  final SFixture sFixture;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FutureBuilder<Team?>(
                future: liveScoreController.getMatchTeam(sFixture.localTeamId),
                builder: (BuildContext context, AsyncSnapshot<Team?> value) {
                  if (value.hasData) {
                    final Team? team = value.data;
                    if (team != null) {
                      return _buildFixtureCard(
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
                      sFixture.scores != null
                          ? sFixture.scores!.localTeamScore.toString()
                          : '0',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      ':',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      sFixture.scores != null
                          ? sFixture.scores!.localTeamScore.toString()
                          : '0',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                TimeCard(
                    dateTime:
                        DateTime.parse(sFixture.time!.startingAt.dateTime)),
                // Container(
                //   padding: const EdgeInsets.symmetric(
                //     vertical: 3,
                //     horizontal: 5,
                //   ),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(5),
                //     color: context.colors.primary.withOpacity(.2),
                //     border: Border.all(
                //       color: context.colors.primary,
                //       width: 1,
                //       style: BorderStyle.solid,
                //     ),
                //   ),
                //   child: Text(
                //     '${sFixture.scores.}\'',
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 14,
                //       color: context.colors.primary,
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: FutureBuilder<Team?>(
                future:
                    liveScoreController.getMatchTeam(sFixture.visitorTeamId),
                builder: (BuildContext context, AsyncSnapshot<Team?> value) {
                  if (value.hasData) {
                    final Team? team = value.data;
                    if (team != null) {
                      return _buildFixtureCard(
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
      ),
    );
  }

  Widget _buildFixtureCard({
    required String imagePath,
    required String name,
  }) {
    return Row(
      children: <Widget>[
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(width: 4),
        SizedBox(
          height: 40,
          width: 40,
          child: Image.network(
            imagePath,
            height: 40,
            width: 40,
          ),
        ),
      ],
    );
  }
}

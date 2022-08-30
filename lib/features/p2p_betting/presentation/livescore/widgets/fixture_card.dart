import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/time_card.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FixtureCard extends StatelessWidget {
  FixtureCard({
    Key? key,
    required this.sFixture,
    required this.onTap,
  }) : super(key: key);

  final LiveScoreController liveScoreController =
      Get.find<LiveScoreController>();

  final LiveScore sFixture;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(
          bottom: 20,
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
                child: _buildRightFixtureCard(
                  imagePath: sFixture.localTeam.data.logo,
                  name: sFixture.localTeam.data.name,
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
                    dateTime: DateTime.parse(
                      sFixture.time.startingAt.dateTime,
                    ),
                  ),
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
                child: _buildLeftFixtureCard(
                  imagePath: sFixture.visitorTeam.data.logo,
                  name: StringUtils.capitalizeFirst(
                    sFixture.visitorTeam.data.name,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRightFixtureCard({
    required String imagePath,
    required String name,
  }) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 8),
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

  Widget _buildLeftFixtureCard({
    required String imagePath,
    required String name,
  }) {
    return Row(
      children: <Widget>[
        SizedBox(
          height: 40,
          width: 40,
          child: Image.network(
            imagePath,
            height: 40,
            width: 40,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

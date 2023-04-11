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
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 5,
              color: Colors.black12,
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: context.colors.faintGrey,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: TimeCard(
                  dateTime: DateTime.parse(
                    sFixture.time.startingAt.dateTime,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _buildLeftFixtureCard(
                      imagePath: sFixture.localTeam.data.logo,
                      name: sFixture.localTeam.data.name,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${sFixture.scores?.localTeamScore ?? 0} - ${sFixture.scores?.visitorTeamScore ?? 0}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: _buildRightFixtureCard(
                      imagePath: sFixture.visitorTeam.data.logo,
                      name: StringUtils.capitalizeFirst(
                        sFixture.visitorTeam.data.name,
                      ),
                    ),
                  ),
                ],
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

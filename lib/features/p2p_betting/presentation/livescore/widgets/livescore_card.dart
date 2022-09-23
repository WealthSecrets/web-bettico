import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class LiveScoreCard extends StatelessWidget {
  LiveScoreCard({
    Key? key,
    required this.liveScore,
    required this.onTap,
  }) : super(key: key);

  final LiveScoreController liveScoreController =
      Get.find<LiveScoreController>();

  final LiveScore liveScore;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                    child: _buildLiveScoreCard(
                      imagePath: liveScore.localTeam.data.logo,
                      name: liveScore.localTeam.data.name,
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
                                ? liveScore.scores!.visitorTeamScore.toString()
                                : '0',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: context.colors.primary.withOpacity(.2),
                          border: Border.all(
                            color: context.colors.primary,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Text(
                          liveScore.time.status?.toLowerCase() == 'ns'
                              ? 'NS'
                              : liveScore.time.status?.toLowerCase() == 'live'
                                  ? '${liveScore.time.minute}\''
                                  : '${liveScore.time.status}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: context.colors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildLiveScoreCard(
                      imagePath: liveScore.visitorTeam.data.logo,
                      name: liveScore.visitorTeam.data.name,
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

  Widget _buildLiveScoreCard({
    required String imagePath,
    required String name,
  }) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                imagePath,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

import 'dart:async';

import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/time_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class LiveScoreCard extends StatefulWidget {
  const LiveScoreCard({
    Key? key,
    required this.liveScore,
    required this.onTap,
  }) : super(key: key);

  final LiveScore liveScore;
  final Function() onTap;

  @override
  State<LiveScoreCard> createState() => _LiveScoreCardState();
}

class _LiveScoreCardState extends State<LiveScoreCard> {
  final LiveScoreController liveScoreController = Get.find<LiveScoreController>();

  Timer? _timer;

  final StreamController<LiveScore?> _liveScoreStreamController = StreamController<LiveScore?>.broadcast();

  @override
  void initState() {
    startBroadcast(widget.liveScore.id);
    super.initState();
  }

  @override
  void dispose() {
    _liveScoreStreamController.close();
    _timer?.cancel();
    super.dispose();
  }

  void startBroadcast(int liveScoreId) async {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
      final LiveScore? sLiveScore = await liveScoreController.getMatchSLiveScore(liveScoreId);

      _liveScoreStreamController.add(sLiveScore);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: StreamBuilder<LiveScore?>(
        stream: _liveScoreStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot<LiveScore?> snapshot) {
          final LiveScore? liveScore = snapshot.data;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      if ((liveScore == null && widget.liveScore.time.status?.toLowerCase() == 'ns') ||
                          (liveScore != null && liveScore.time.status?.toLowerCase() == 'ns'))
                        TimeCard(
                          dateTime: DateTime.parse(
                            widget.liveScore.time.startingAt.dateTime,
                          ),
                          showOnlyTime: true,
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: _buildLiveScoreCard(
                          imagePath: widget.liveScore.localTeam.data.logo,
                          name: widget.liveScore.localTeam.data.name,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                snapshot.hasData && snapshot.data != null
                                    ? '${snapshot.data!.scores?.localTeamScore}'
                                    : widget.liveScore.scores != null
                                        ? widget.liveScore.scores!.localTeamScore.toString()
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
                                snapshot.hasData && snapshot.data != null
                                    ? '${snapshot.data!.scores?.visitorTeamScore}'
                                    : widget.liveScore.scores != null
                                        ? widget.liveScore.scores!.visitorTeamScore.toString()
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
                              liveScore != null
                                  ? (liveScore.time.status?.toLowerCase() == 'ns'
                                      ? 'NS'
                                      : liveScore.time.status?.toLowerCase() == 'live'
                                          ? '${liveScore.time.minute}\''
                                          : '${liveScore.time.status}')
                                  : (widget.liveScore.time.status?.toLowerCase() == 'ns'
                                      ? 'NS'
                                      : widget.liveScore.time.status?.toLowerCase() == 'live'
                                          ? '${widget.liveScore.time.minute}\''
                                          : '${widget.liveScore.time.status}'),
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
                          imagePath: widget.liveScore.visitorTeam.data.logo,
                          name: widget.liveScore.visitorTeam.data.name,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
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

import 'dart:async';

import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/sports/sports_controlller.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  final SportsController controller = Get.find<SportsController>();

  @override
  void initState() {
    super.initState();
    controller.getLiveScores();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return AppLoadingBox(
          loading: controller.isFetchingLiveScores.value,
          child: controller.livescores.isEmpty
              ? const AppEmptyScreen(message: 'Oops! No live matches are available.')
              : ListView.builder(
                  padding: isSmallScreen ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) => _LiveScoreCard(
                    livescore: controller.livescores[index],
                  ),
                  itemCount: controller.livescores.length,
                ),
        );
      },
    );
  }

  bool get isSmallScreen => ResponsiveWidget.isSmallScreen(context);
}

class _LiveScoreCard extends StatefulWidget {
  const _LiveScoreCard({Key? key, required this.livescore}) : super(key: key);

  final LiveScore livescore;

  @override
  State<_LiveScoreCard> createState() => _LiveScoreCardState();
}

class _LiveScoreCardState extends State<_LiveScoreCard> {
  final LiveScoreController liveScoreController = Get.find<LiveScoreController>();

  Timer? _timer;

  final StreamController<LiveScore?> _liveScoreStreamController = StreamController<LiveScore?>.broadcast();

  @override
  void initState() {
    startBroadcast(widget.livescore.id);
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
    return Container(
      width: double.infinity,
      margin: AppPaddings.mB,
      padding: AppPaddings.mV,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 5,
            color: Colors.black12,
            offset: Offset(0, 1),
          )
        ],
        borderRadius: AppBorderRadius.smallAll,
        border: Border.all(
          color: context.colors.faintGrey,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Stack(
        children: <Widget>[
          _TeamCardColumn(livescore: widget.livescore),
          StreamBuilder<LiveScore?>(builder: (BuildContext context, AsyncSnapshot<LiveScore?> snapshot) {
            final LiveScore? livescore = snapshot.data;
            return Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      livescore != null
                          ? livescore.time.status?.toLowerCase() == 'ns'
                              ? 'NS'
                              : livescore.time.status?.toLowerCase() == 'live'
                                  ? '${livescore.time.minute}\''
                                  : '${livescore.time.status}'
                          : 'FT',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _TeamCardColumn extends StatelessWidget {
  const _TeamCardColumn({
    Key? key,
    required this.livescore,
  }) : super(key: key);

  final LiveScore livescore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _TeamRow(
          logo: livescore.localTeam.data.logo,
          name: livescore.localTeam.data.name,
          score: livescore.scores!.localTeamScore,
        ),
        const Divider(),
        _TeamRow(
          logo: livescore.visitorTeam.data.logo,
          name: livescore.visitorTeam.data.name,
          score: livescore.scores!.visitorTeamScore,
        ),
      ],
    );
  }
}

class _TeamRow extends StatelessWidget {
  const _TeamRow({
    Key? key,
    required this.logo,
    required this.name,
    required this.score,
  }) : super(key: key);

  final String logo;
  final String name;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.lH,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.network(logo, height: 25, width: 25),
          const SizedBox(width: 8),
          Text(
            name,
            style: TextStyle(color: context.colors.textDark, fontSize: 12),
          ),
          const Spacer(),
          Text(
            '$score',
            style: TextStyle(
              color: context.colors.textDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

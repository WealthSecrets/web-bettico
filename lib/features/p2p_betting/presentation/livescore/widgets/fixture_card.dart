import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/time_card.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FixtureCard extends StatefulWidget {
  const FixtureCard({
    Key? key,
    required this.sFixture,
    required this.onTap,
  }) : super(key: key);

  final LiveScore sFixture;
  final Function() onTap;

  @override
  State<FixtureCard> createState() => _FixtureCardState();
}

class _FixtureCardState extends State<FixtureCard> {
  final LiveScoreController liveScoreController =
      Get.find<LiveScoreController>();

  @override
  Widget build(BuildContext context) {
    final double fontSize = isSmallScreen
        ? 12
        : isCustomScreen
            ? 14
            : isMediumScreen
                ? 16
                : 18;
    return GestureDetector(
      onTap: widget.onTap,
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
                    widget.sFixture.time.startingAt.dateTime,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _LeftFixtureCard(
                      imagePath: widget.sFixture.localTeam.data.logo,
                      text: _FixtureText(
                        isSmallScreen: isSmallScreen,
                        isMediumScreen: isMediumScreen,
                        isCustomScreen: isCustomScreen,
                        name: StringUtils.capitalizeFirst(
                          widget.sFixture.localTeam.data.name,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Vs',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: context.colors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: _RightFixtureCard(
                      imagePath: widget.sFixture.visitorTeam.data.logo,
                      text: _FixtureText(
                        isSmallScreen: isSmallScreen,
                        isMediumScreen: isMediumScreen,
                        isCustomScreen: isCustomScreen,
                        name: StringUtils.capitalizeFirst(
                          widget.sFixture.visitorTeam.data.name,
                        ),
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

  bool get isSmallScreen => ResponsiveWidget.isSmallScreen(context);
  bool get isCustomScreen => ResponsiveWidget.isCustomSize(context);
  bool get isMediumScreen => ResponsiveWidget.isMediumScreen(context);
}

class _LeftFixtureCard extends StatelessWidget {
  const _LeftFixtureCard({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  final String imagePath;
  final _FixtureText text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
        text,
      ],
    );
  }
}

class _RightFixtureCard extends StatelessWidget {
  const _RightFixtureCard({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  final String imagePath;
  final _FixtureText text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        text,
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
}

class _FixtureText extends StatelessWidget {
  const _FixtureText({
    Key? key,
    required this.name,
    required this.isSmallScreen,
    required this.isMediumScreen,
    required this.isCustomScreen,
  }) : super(key: key);

  final String name;

  final bool isSmallScreen;
  final bool isMediumScreen;
  final bool isCustomScreen;

  @override
  Widget build(BuildContext context) {
    final double fontSize = isSmallScreen
        ? 12
        : isCustomScreen
            ? 14
            : isMediumScreen
                ? 16
                : 18;
    return Text(
      name,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

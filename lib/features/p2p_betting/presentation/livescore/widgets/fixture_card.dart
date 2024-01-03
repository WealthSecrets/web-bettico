import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FixtureCard extends StatefulWidget {
  const FixtureCard({super.key, required this.sFixture, required this.onTap});

  final LiveScore sFixture;
  final Function() onTap;

  @override
  State<FixtureCard> createState() => _FixtureCardState();
}

class _FixtureCardState extends State<FixtureCard> {
  final LiveScoreController liveScoreController = Get.find<LiveScoreController>();

  @override
  Widget build(BuildContext context) {
    final double fontSize = isSmallScreen || isCustomScreen
        ? 12
        : isMediumScreen
            ? 14
            : 16;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const <BoxShadow>[BoxShadow(blurRadius: 5, color: Colors.black12, offset: Offset(0, 1))],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.colors.faintGrey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: TimeCard(dateTime: DateTime.parse(widget.sFixture.time.startingAt.dateTime)),
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _LeftFixtureCard(
                      imagePath: widget.sFixture.localTeam.data.logo,
                      text: _FixtureText(
                        fontSize: fontSize,
                        name: StringUtils.capitalizeFirst(widget.sFixture.localTeam.data.name),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Vs',
                    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: context.colors.primary),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _RightFixtureCard(
                      imagePath: widget.sFixture.visitorTeam.data.logo,
                      text: _FixtureText(
                        fontSize: fontSize,
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
  const _LeftFixtureCard({required this.imagePath, required this.text});

  final String imagePath;
  final _FixtureText text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(height: 40, width: 40, child: Image.network(imagePath, height: 40, width: 40)),
        const SizedBox(width: 8),
        text,
      ],
    );
  }
}

class _RightFixtureCard extends StatelessWidget {
  const _RightFixtureCard({required this.imagePath, required this.text});

  final String imagePath;
  final _FixtureText text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        text,
        const SizedBox(width: 8),
        SizedBox(height: 40, width: 40, child: Image.network(imagePath, height: 40, width: 40)),
      ],
    );
  }
}

class _FixtureText extends StatelessWidget {
  const _FixtureText({required this.name, required this.fontSize});

  final String name;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.normal, color: context.colors.textDark),
      textAlign: TextAlign.center,
    );
  }
}

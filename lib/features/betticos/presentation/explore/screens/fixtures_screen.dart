import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/sports/sports_controlller.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/widgets/fixture_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FixturesScreen extends StatefulWidget {
  const FixturesScreen({Key? key}) : super(key: key);

  @override
  State<FixturesScreen> createState() => _FixturesScreenState();
}

class _FixturesScreenState extends State<FixturesScreen> {
  final SportsController lController = Get.find<SportsController>();

  @override
  void initState() {
    super.initState();
    lController.getSFixtures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => AppLoadingBox(
          loading: lController.isFetchingFixtures.value,
          child: lController.sFixtures.isEmpty && !lController.isFetchingFixtures.value
              ? const AppEmptyScreen(message: 'Oops! No fixtures are available.')
              : ListView(
                  padding: isSmallScreen ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero,
                  children: lController.sFixtures
                      .map(
                        (LiveScore liveScore) => FixtureCard(
                          sFixture: liveScore,
                          onTap: () {},
                        ),
                      )
                      .toList(),
                ),
        ),
      ),
    );
  }

  bool get isSmallScreen => ResponsiveWidget.isSmallScreen(context);
}

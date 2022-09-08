import 'package:betticos/features/p2p_betting/domain/usecases/crypto/convert_amount_to_currency.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/live_score/get_fixtures.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/fetch_fixtures.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/fetch_leagues.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/fetch_livescores.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/fetch_paginated_fixture.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/fetch_paginated_livescore.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/get_sfixture.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/get_team.dart';
import 'package:get/get.dart';

import '/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import '../../../domain/usecases/live_score/get_live_matches.dart';
import '../../../domain/usecases/sportmonks/get_league.dart';

class LiveScoreBindings {
  static void dependencies() {
    Get.lazyPut(
      () => LiveScoreController(
        getLiveMatches: GetLiveMatches(
          p2pRepository: Get.find(),
        ),
        getFixtures: GetFixtures(
          p2pRepository: Get.find(),
        ),
        convertAmountToCurrency: ConvertAmountToCurrency(
          p2pRepository: Get.find(),
        ),
        fetchPaginatedLiveScore: FetchPaginatedLiveScore(
          p2pRepository: Get.find(),
        ),
        fetchPaginatedFixtures: FetchPaginatedFixtures(
          p2pRepository: Get.find(),
        ),
        fetchLeagues: FetchLeagues(
          p2pRepository: Get.find(),
        ),
        getTeam: GetTeam(
          p2pRepository: Get.find(),
        ),
        getLeague: GetLeague(
          p2pRepository: Get.find(),
        ),
        fetchLiveScores: FetchLiveScores(
          p2pRepository: Get.find(),
        ),
        fetchFixtures: FetchFixtures(
          p2pRepository: Get.find(),
        ),
        getSFixture: GetSFixture(
          p2pRepository: Get.find(),
        ),
      ),
    );
  }
}

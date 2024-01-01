import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';

import 'live_score_controllers.dart';

class LiveScoreBindings {
  static void dependencies() {
    Get.put(
      LiveScoreController(
        fetchPaginatedLiveScore: FetchPaginatedLiveScore(p2pRepository: Get.find()),
        fetchPaginatedFixtures: FetchPaginatedFixtures(p2pRepository: Get.find()),
        fetchLeagues: FetchLeagues(p2pRepository: Get.find()),
        getTeam: GetTeam(p2pRepository: Get.find()),
        getLeague: GetLeague(p2pRepository: Get.find()),
        fetchLiveScores: FetchLiveScores(p2pRepository: Get.find()),
        fetchFixtures: FetchFixtures(p2pRepository: Get.find()),
        getSFixture: GetSFixture(p2pRepository: Get.find()),
        getSLiveScore: GetSLiveScore(p2pRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}

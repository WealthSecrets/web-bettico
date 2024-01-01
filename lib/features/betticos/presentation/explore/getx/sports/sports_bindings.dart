import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';
import 'sports_controlller.dart';

class SportsBindings {
  static void dependencies() {
    Get.put(
      SportsController(
        fetchLiveScores: FetchLiveScores(p2pRepository: Get.find()),
        fetchFixtures: FetchFixtures(p2pRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}

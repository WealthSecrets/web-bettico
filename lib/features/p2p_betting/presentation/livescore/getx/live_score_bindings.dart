import 'package:betticos/features/p2p_betting/domain/usecases/live_score/get_fixtures.dart';
import 'package:get/get.dart';

import '/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import '../../../domain/usecases/live_score/get_live_matches.dart';

// class LiveScoreBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(
//       () => LiveScoreController(
//         getLiveMatches: GetLiveMatches(
//           p2pRepository: Get.find(),
//         ),
//         getFixtures: GetFixtures(
//           p2pRepository: Get.find(),
//         ),
//       ),
//     );
//   }
// }

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
      ),
    );
  }
}

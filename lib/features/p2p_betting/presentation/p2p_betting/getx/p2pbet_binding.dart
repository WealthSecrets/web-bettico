import 'package:betticos/features/p2p_betting/domain/usecases/bet/fetch_awaiting_bets.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/bet/fetch_mybets.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/bet/update_bet.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/live_score/get_competition_match.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/live_score/get_fixture.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/live_score/get_team_match.dart';
import 'package:get/get.dart';

import '/features/p2p_betting/domain/usecases/bet/fetch_bets.dart';
import '/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import '../../../domain/usecases/bet/add_bet.dart';

// class P2PBetBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(
//       () => P2PBetController(
//         addBet: AddBet(
//           p2prepository: Get.find(),
//         ),
//         fetchBets: FetchBets(
//           p2pRepository: Get.find(),
//         ),
//         getCompetitionMatch: GetCompetitionMatch(
//           p2pRepository: Get.find(),
//         ),
//         getTeamMatch: GetTeamMatch(
//           p2pRepository: Get.find(),
//         ),
//         fetchAwaitingBets: FetchAwaitingBets(
//           p2pRepository: Get.find(),
//         ),
//         updateBet: UpdateBet(
//           p2prepository: Get.find(),
//         ),
//         getFixture: GetFixture(
//           p2pRepository: Get.find(),
//         ),
//         fetchMyBets: FetchMyBets(
//           p2pRepository: Get.find(),
//         ),
//       ),
//     );
//   }
// }

class P2PBetBindings {
  static void dependencies() {
    Get.lazyPut(
      () => P2PBetController(
        addBet: AddBet(
          p2prepository: Get.find(),
        ),
        fetchBets: FetchBets(
          p2pRepository: Get.find(),
        ),
        getCompetitionMatch: GetCompetitionMatch(
          p2pRepository: Get.find(),
        ),
        getTeamMatch: GetTeamMatch(
          p2pRepository: Get.find(),
        ),
        fetchAwaitingBets: FetchAwaitingBets(
          p2pRepository: Get.find(),
        ),
        updateBet: UpdateBet(
          p2prepository: Get.find(),
        ),
        getFixture: GetFixture(
          p2pRepository: Get.find(),
        ),
        fetchMyBets: FetchMyBets(
          p2pRepository: Get.find(),
        ),
      ),
    );
  }
}

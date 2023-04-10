import 'package:betticos/features/betticos/presentation/explore/getx/sports/sports_controlller.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/fetch_livescores.dart';
import 'package:get/get.dart';

class SportsBindings {
  static void dependencies() {
    Get.put(
      SportsController(
        fetchLiveScores: FetchLiveScores(
          p2pRepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}

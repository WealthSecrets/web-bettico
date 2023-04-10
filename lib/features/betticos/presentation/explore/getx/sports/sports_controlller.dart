import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/domain/requests/sportmonks/nullable_livescore_request.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/fetch_livescores.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class SportsController extends GetxController {
  SportsController({
    required this.fetchLiveScores,
  });

  final FetchLiveScores fetchLiveScores;

  // observable variables
  RxBool isFetchingLiveScores = false.obs;
  RxList<LiveScore> livescores = <LiveScore>[].obs;

  void getLiveScores() async {
    isFetchingLiveScores(true);
    final Either<Failure, List<LiveScore>> failureOrLiveScores =
        await fetchLiveScores(const NullLiveScoreRequest());
    failureOrLiveScores.fold<void>(
      (Failure failure) {
        isFetchingLiveScores(false);
      },
      (List<LiveScore> value) {
        isFetchingLiveScores(false);
        final List<LiveScore> copyLiveScores = List<LiveScore>.from(value);
        copyLiveScores
            .removeWhere((LiveScore l) => l.time.status?.toLowerCase() == 'ft');
        livescores.value = copyLiveScores;
      },
    );
  }
}

import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class SportsController extends GetxController {
  SportsController({
    required this.fetchLiveScores,
    required this.fetchFixtures,
  });

  final FetchLiveScores fetchLiveScores;
  final FetchFixtures fetchFixtures;

  // observable variables
  RxBool isFetchingLiveScores = false.obs;
  RxList<LiveScore> livescores = <LiveScore>[].obs;
  RxList<LiveScore> sFixtures = <LiveScore>[].obs;

  RxBool isFetchingFixtures = false.obs;

  void getLiveScores() async {
    isFetchingLiveScores(true);
    final Either<Failure, List<LiveScore>> failureOrLiveScores = await fetchLiveScores(const NullLiveScoreRequest());
    failureOrLiveScores.fold<void>(
      (Failure failure) {
        isFetchingLiveScores(false);
      },
      (List<LiveScore> value) {
        isFetchingLiveScores(false);
        livescores.value = value;
      },
    );
  }

  void getSFixtures() async {
    isFetchingFixtures(true);
    final Either<Failure, List<LiveScore>> failureOrSFixtures = await fetchFixtures(const NullLiveScoreRequest());
    failureOrSFixtures.fold<void>(
      (Failure failure) {
        isFetchingFixtures(false);
      },
      (List<LiveScore> value) {
        isFetchingFixtures(false);
        final DateTime now = DateTime.now();
        final DateTime today = DateTime(now.year, now.month, now.day);

        final List<LiveScore> copyLiveScores = List<LiveScore>.from(value);
        copyLiveScores.removeWhere((LiveScore l) {
          final DateTime lDateTime = DateTime.parse(
            l.time.startingAt.dateTime,
          );
          return lDateTime.isBefore(today);
        });
        sFixtures.value = value;
      },
    );
  }
}

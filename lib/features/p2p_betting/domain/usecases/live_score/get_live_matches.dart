import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';
import '/features/p2p_betting/domain/requests/live_score/live_scores_request.dart';

class GetLiveMatches implements UseCase<List<SoccerMatch>, LiveScoreRequest> {
  GetLiveMatches({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, List<SoccerMatch>>> call(LiveScoreRequest params) {
    return p2pRepository.getLiveMatches(
      params.apiKey,
      params.secretKey,
    );
  }
}

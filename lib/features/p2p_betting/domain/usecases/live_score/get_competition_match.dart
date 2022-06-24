import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';
import '../../requests/live_score/live_competition_request.dart';

class GetCompetitionMatch
    implements UseCase<SoccerMatch?, LiveCompetitionRequest> {
  GetCompetitionMatch({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, SoccerMatch?>> call(LiveCompetitionRequest params) {
    return p2pRepository.getCompetitionMatch(
      params.apiKey,
      params.secretKey,
      params.competitionId,
      params.teamId,
    );
  }
}

import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';
import '/features/p2p_betting/domain/requests/live_score/live_team_request.dart';

class GetTeamMatch implements UseCase<SoccerMatch?, LiveTeamRequest> {
  GetTeamMatch({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, SoccerMatch?>> call(LiveTeamRequest params) {
    return p2pRepository.getTeamMatch(
      params.apiKey,
      params.secretKey,
      params.teamId,
      params.competitionId,
      params.date,
    );
  }
}

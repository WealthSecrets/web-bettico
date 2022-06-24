import 'package:betticos/features/p2p_betting/domain/requests/live_score/fixture_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class GetFixture implements UseCase<SoccerMatch?, FixtureRequest> {
  GetFixture({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, SoccerMatch?>> call(FixtureRequest params) {
    return p2pRepository.getFixture(
      params.apiKey,
      params.secretKey,
      params.competitionId,
      params.teamId,
      params.date,
    );
  }
}

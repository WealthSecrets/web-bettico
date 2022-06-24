import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';
import '/features/p2p_betting/domain/requests/live_score/live_scores_request.dart';

class GetFixtures implements UseCase<List<Fixture>, LiveScoreRequest> {
  GetFixtures({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, List<Fixture>>> call(LiveScoreRequest params) {
    return p2pRepository.getFixtures(
      params.apiKey,
      params.secretKey,
    );
  }
}

import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/domain/requests/sportmonks/nullable_livescore_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class FetchFixtures implements UseCase<List<LiveScore>, NullLiveScoreRequest> {
  FetchFixtures({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, List<LiveScore>>> call(NullLiveScoreRequest params) {
    return p2pRepository.fetchFixtures(leagueId: params.leagueId);
  }
}

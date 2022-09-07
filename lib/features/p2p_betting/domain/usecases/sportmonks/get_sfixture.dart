import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/domain/repositories/p2p_repository.dart';
import 'package:betticos/features/p2p_betting/domain/requests/sportmonks/s_fixture_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class GetSFixture implements UseCase<LiveScore, SFixtureRequest> {
  GetSFixture({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, LiveScore>> call(SFixtureRequest params) {
    return p2pRepository.getSFixture(params.fixtureId);
  }
}

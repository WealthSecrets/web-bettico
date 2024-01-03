import 'package:betticos/features/domain.dart';
import 'package:betticos/features/p2p_betting/data/data.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class GetSLiveScore implements UseCase<LiveScore, SFixtureRequest> {
  GetSLiveScore({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, LiveScore>> call(SFixtureRequest params) {
    return p2pRepository.getSLiveScore(params.fixtureId);
  }
}

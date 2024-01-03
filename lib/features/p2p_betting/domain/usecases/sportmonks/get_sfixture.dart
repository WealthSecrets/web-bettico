import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
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

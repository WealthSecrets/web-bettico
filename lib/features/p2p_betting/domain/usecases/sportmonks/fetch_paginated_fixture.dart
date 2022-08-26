import 'package:betticos/features/p2p_betting/domain/repositories/p2p_repository.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/listpage/listpage.dart';
import '../../../data/models/sportmonks/fixture/fixture.dart';

class FetchPaginatedFixtures
    implements UseCase<ListPage<SFixture>, PageParmas> {
  FetchPaginatedFixtures({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, ListPage<SFixture>>> call(PageParmas params) {
    return p2pRepository.fetchPaginatedFixtures(
      params.page,
      params.size,
      params.leagueId,
    );
  }
}

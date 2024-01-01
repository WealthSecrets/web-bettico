import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchPaginatedFixtures implements UseCase<ListPage<LiveScore>, PageParmas> {
  FetchPaginatedFixtures({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, ListPage<LiveScore>>> call(PageParmas params) {
    return p2pRepository.fetchPaginatedFixtures(params.page, params.size, params.leagueId);
  }
}

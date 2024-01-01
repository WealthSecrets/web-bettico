import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class FetchPaginatedLiveScore implements UseCase<ListPage<LiveScore>, PageParmas> {
  FetchPaginatedLiveScore({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, ListPage<LiveScore>>> call(PageParmas params) {
    return p2pRepository.fetchPaginatedLiveScores(params.page, params.size, params.leagueId);
  }
}

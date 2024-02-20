import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchPaginatedReposts implements UseCase<ListPage<Repost>, PageParmas> {
  FetchPaginatedReposts({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, ListPage<Repost>>> call(PageParmas params) {
    return betticosRepository.fetchPaginatedReposts(params.page, params.size);
  }
}

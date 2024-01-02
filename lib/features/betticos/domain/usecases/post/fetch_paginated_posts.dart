import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchPaginatedPosts implements UseCase<ListPage<Post>, PageParmas> {
  FetchPaginatedPosts({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, ListPage<Post>>> call(PageParmas params) {
    return betticosRepository.fetchPaginatedPosts(params.page, params.size);
  }
}

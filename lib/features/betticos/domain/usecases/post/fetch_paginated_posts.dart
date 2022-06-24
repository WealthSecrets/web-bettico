import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/listpage/listpage.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class FetchPaginatedPosts implements UseCase<ListPage<Post>, PageParmas> {
  FetchPaginatedPosts({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, ListPage<Post>>> call(PageParmas params) {
    return betticosRepository.fetchPaginatedPosts(params.page, params.size);
  }
}

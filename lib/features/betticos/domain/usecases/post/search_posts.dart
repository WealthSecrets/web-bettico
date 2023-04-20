import 'package:betticos/features/betticos/domain/response/search_response.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class SearchPosts implements UseCase<SearchResponse, SearchPageParams> {
  SearchPosts({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, SearchResponse>> call(SearchPageParams params) {
    return betticosRepository.searchPosts(params.keyword, params.page, params.size);
  }
}

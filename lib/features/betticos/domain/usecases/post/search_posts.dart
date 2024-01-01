import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '../../repositories/repositories.dart';
import '../../response/response.dart';

class SearchPosts implements UseCase<SearchResponse, SearchPageParams> {
  SearchPosts({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, SearchResponse>> call(SearchPageParams params) {
    return betticosRepository.searchPosts(params.keyword, params.page, params.size);
  }
}

import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class SearchPosts implements UseCase<SearchResponse, SearchPageParams> {
  SearchPosts({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, SearchResponse>> call(SearchPageParams params) {
    return betticosRepository.searchPosts(params.keyword, params.page, params.size);
  }
}

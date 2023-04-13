import 'package:betticos/core/models/paginated_response_data.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class SearchPosts
    implements UseCase<PaginatedResponseData<Post>, SearchPageParams> {
  SearchPosts({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, PaginatedResponseData<Post>>> call(
      SearchPageParams params) {
    return betticosRepository.searchPosts(
        params.keyword, params.page, params.size);
  }
}

import 'package:betticos/core/models/paginated_response_data.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class ExplorePosts implements UseCase<PaginatedResponseData<Post>, PageParmas> {
  ExplorePosts({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, PaginatedResponseData<Post>>> call(PageParmas params) {
    return betticosRepository.explorePosts(params.page, params.size);
  }
}

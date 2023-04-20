import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '/features/betticos/domain/requests/post/fetch_post_comments_request.dart';

class FetchPostComments implements UseCase<List<Post>, FetchPostCommentsRequest> {
  FetchPostComments({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<Post>>> call(FetchPostCommentsRequest params) {
    return betticosRepository.fetchPostComments(params.postId);
  }
}

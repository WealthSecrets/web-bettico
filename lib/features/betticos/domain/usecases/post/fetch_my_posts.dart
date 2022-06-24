import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '/features/betticos/domain/requests/post/my_posts_or_oddboxes_request.dart';

class FetchMyPosts implements UseCase<List<Post>, MyPostsOrOddboxesRequest> {
  FetchMyPosts({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<Post>>> call(MyPostsOrOddboxesRequest params) {
    return betticosRepository.getMyPosts(params.userId);
  }
}

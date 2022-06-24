import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '/features/betticos/domain/requests/post/like_dislike_post_params.dart';

class LikePost implements UseCase<Post, LikeDislikePostParams> {
  LikePost({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Post>> call(LikeDislikePostParams params) {
    return betticosRepository.likePost(
      postId: params.postId,
      user: params.user,
    );
  }
}

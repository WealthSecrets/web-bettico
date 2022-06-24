import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '/features/betticos/domain/requests/post/like_dislike_post_params.dart';

class DislikePost implements UseCase<Post, LikeDislikePostParams> {
  DislikePost({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Post>> call(LikeDislikePostParams params) {
    return betticosRepository.dislikePost(
      postId: params.postId,
      user: params.user,
    );
  }
}

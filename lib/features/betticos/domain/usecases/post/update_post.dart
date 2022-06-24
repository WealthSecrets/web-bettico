import 'package:betticos/features/betticos/domain/requests/post/update_post_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class UpdatePost implements UseCase<Post, UpdatePostRequest> {
  UpdatePost({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Post>> call(UpdatePostRequest params) {
    return betticosRepository.updatePost(
      postId: params.postId,
      text: params.text,
      isOddbox: params.isOddbox,
      slipCode: params.slipCode,
      dislikeUsers: params.dislikeUsers,
      likeUsers: params.likeUsers,
      shares: params.shares,
    );
  }
}

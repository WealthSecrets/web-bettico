import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

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

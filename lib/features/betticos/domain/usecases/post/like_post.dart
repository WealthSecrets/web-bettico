import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class LikePost implements UseCase<Post, LikeDislikePostParams> {
  LikePost({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Post>> call(LikeDislikePostParams params) {
    return betticosRepository.likePost(postId: params.postId, user: params.user);
  }
}

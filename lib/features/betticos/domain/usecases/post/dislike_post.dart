import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class DislikePost implements UseCase<Post, LikeDislikePostParams> {
  DislikePost({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Post>> call(LikeDislikePostParams params) {
    return betticosRepository.dislikePost(postId: params.postId, user: params.user);
  }
}

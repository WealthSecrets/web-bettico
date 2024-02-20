import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class DislikeRepost implements UseCase<Repost, LikeDislikePostParams> {
  DislikeRepost({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Repost>> call(LikeDislikePostParams params) {
    return betticosRepository.dislikeRepost(repostId: params.postId, user: params.user);
  }
}

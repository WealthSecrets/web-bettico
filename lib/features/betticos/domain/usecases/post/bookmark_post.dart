import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class BookmarkPost implements UseCase<Post, LikeDislikePostParams> {
  BookmarkPost({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Post>> call(LikeDislikePostParams params) {
    return betticosRepository.bookmarkPost(postId: params.postId, user: params.user);
  }
}

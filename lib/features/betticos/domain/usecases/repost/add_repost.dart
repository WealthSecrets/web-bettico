import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class AddRepost implements UseCase<Repost, RepostRequest> {
  AddRepost({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Repost>> call(RepostRequest params) {
    return betticosRepository.addRepost(postId: params.postId, commentsOnRepost: params.commentsOnRepost);
  }
}

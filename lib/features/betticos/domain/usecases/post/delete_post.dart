import 'package:betticos/features/betticos/domain/requests/post/delete_post_params.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class DeletePost implements UseCase<void, DeletePostParams> {
  DeletePost({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, void>> call(DeletePostParams params) {
    return betticosRepository.deletePost(
      postId: params.postId,
    );
  }
}

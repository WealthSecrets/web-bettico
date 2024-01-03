import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class DeletePost implements UseCase<void, DeletePostParams> {
  DeletePost({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, void>> call(DeletePostParams params) {
    return betticosRepository.deletePost(postId: params.postId);
  }
}

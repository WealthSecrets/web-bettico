import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchPostComments implements UseCase<List<Post>, FetchPostCommentsRequest> {
  FetchPostComments({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<Post>>> call(FetchPostCommentsRequest params) {
    return betticosRepository.fetchPostComments(params.postId);
  }
}

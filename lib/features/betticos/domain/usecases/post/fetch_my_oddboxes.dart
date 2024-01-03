import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchMyOddboxes implements UseCase<List<Post>, MyPostsOrOddboxesRequest> {
  FetchMyOddboxes({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<Post>>> call(MyPostsOrOddboxesRequest params) {
    return betticosRepository.getMyOddboxes(params.userId);
  }
}

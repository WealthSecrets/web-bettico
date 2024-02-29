import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetMyBookmarks implements UseCase<List<Post>, UserRequest> {
  GetMyBookmarks({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<Post>>> call(UserRequest params) {
    return betticosRepository.getMyBookmarks(params.userId);
  }
}

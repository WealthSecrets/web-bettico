import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetMyBookmarks implements UseCase<List<Post>, NoParams> {
  GetMyBookmarks({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) {
    return betticosRepository.getMyBookmarks();
  }
}

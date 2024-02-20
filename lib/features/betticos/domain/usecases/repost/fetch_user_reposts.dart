import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchUserReposts implements UseCase<List<Repost>, UserRequest> {
  FetchUserReposts({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<Repost>>> call(UserRequest params) {
    return betticosRepository.getUserReposts(params.userId);
  }
}

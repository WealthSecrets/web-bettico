import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchUserReposts implements UseCase<List<RepostResponse>, UserRequest> {
  FetchUserReposts({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<RepostResponse>>> call(UserRequest params) {
    return betticosRepository.getUserReposts(params.userId);
  }
}

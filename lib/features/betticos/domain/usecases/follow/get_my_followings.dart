import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetMyFollowings implements UseCase<List<User>, UserRequest> {
  GetMyFollowings({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<User>>> call(UserRequest params) {
    return betticosRepository.getMyFollowings(params.userId);
  }
}

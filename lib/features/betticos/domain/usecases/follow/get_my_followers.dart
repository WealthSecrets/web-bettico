import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetMyFollowers implements UseCase<List<User>, UserRequest> {
  GetMyFollowers({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<User>>> call(UserRequest params) {
    return betticosRepository.getMyFollowers(params.userId);
  }
}

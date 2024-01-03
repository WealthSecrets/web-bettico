import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class CheckFollowing implements UseCase<Follow, UserRequest> {
  CheckFollowing({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Follow>> call(UserRequest params) {
    return betticosRepository.checkFollowing(userId: params.userId);
  }
}

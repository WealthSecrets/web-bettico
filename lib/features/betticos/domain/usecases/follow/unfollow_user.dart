import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class UnfollowerUser implements UseCase<void, UserRequest> {
  UnfollowerUser({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, void>> call(UserRequest params) {
    return betticosRepository.unfollowUser(userId: params.userId);
  }
}

import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '../../requests/follow/user_request.dart';

class UnfollowerUser implements UseCase<void, UserRequest> {
  UnfollowerUser({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, void>> call(UserRequest params) {
    return betticosRepository.unfollowUser(
      userId: params.userId,
    );
  }
}

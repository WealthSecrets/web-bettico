import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '/features/betticos/domain/requests/follow/user_request.dart';

class BlockUser implements UseCase<User, UserRequest> {
  BlockUser({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, User>> call(UserRequest params) {
    return betticosRepository.blockUser(
      userId: params.userId,
    );
  }
}

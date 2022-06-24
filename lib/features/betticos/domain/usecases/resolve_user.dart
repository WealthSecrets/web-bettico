import 'package:betticos/features/betticos/domain/repositories/betticos_repository.dart';
import 'package:betticos/features/betticos/domain/requests/user/resolve_user_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';

class ResolveUser implements UseCase<User, ResolveUserRequest> {
  ResolveUser({required this.betticosRepository});
  BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, User>> call(ResolveUserRequest params) {
    return betticosRepository.resolveUser(userId: params.userId);
  }
}

import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/domain/requests/verify_user/verify_user_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class VerifyUser implements UseCase<User, VerifyUserRequest> {
  VerifyUser({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(VerifyUserRequest params) {
    return authRepository.verifyUser(params);
  }
}

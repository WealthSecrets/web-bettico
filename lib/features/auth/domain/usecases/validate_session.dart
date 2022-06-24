import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class ValidateSession implements UseCase<User, NoParams> {
  ValidateSession({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return authRepository.validateSession();
  }
}

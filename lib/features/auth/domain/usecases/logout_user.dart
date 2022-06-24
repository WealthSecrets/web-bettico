import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class LogoutUser implements UseCase<void, NoParams> {
  LogoutUser({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return authRepository.logout();
  }
}

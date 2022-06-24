import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class IsAuthenticated implements UseCase<bool, NoParams> {
  IsAuthenticated({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return authRepository.isAuthenticated();
  }
}

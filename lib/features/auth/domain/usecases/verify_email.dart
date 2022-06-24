import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/repositories/auth_repository.dart';
import '/features/auth/domain/requests/verify_email/verify_email_request.dart';

class VerifyEmail implements UseCase<User, VerifyEmailRequest> {
  VerifyEmail({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(VerifyEmailRequest params) {
    return authRepository.verifyEmail(params);
  }
}

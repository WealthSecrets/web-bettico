import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/repositories/auth_repository.dart';
import '/features/auth/domain/requests/resend_email/resend_email_request.dart';

class ResendEmail implements UseCase<User, ResendEmailRequest> {
  ResendEmail({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(ResendEmailRequest params) {
    return authRepository.resendEmail(params);
  }
}

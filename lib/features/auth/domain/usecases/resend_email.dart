import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class ResendEmail implements UseCase<User, ResendEmailRequest> {
  ResendEmail({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(ResendEmailRequest params) {
    return authRepository.resendEmail(params);
  }
}

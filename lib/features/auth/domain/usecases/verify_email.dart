import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class VerifyEmail implements UseCase<User, VerifyEmailRequest> {
  VerifyEmail({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(VerifyEmailRequest params) {
    return authRepository.verifyEmail(params);
  }
}

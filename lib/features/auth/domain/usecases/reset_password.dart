import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class ResetPassword implements UseCase<User, ResetRequest> {
  ResetPassword({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(ResetRequest params) {
    return authRepository.resetPassword(params);
  }
}

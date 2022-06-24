import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/domain/repositories/auth_repository.dart';
import 'package:betticos/features/auth/domain/requests/reset_request/reset_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class ResetPassword implements UseCase<User, ResetRequest> {
  ResetPassword({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(ResetRequest params) {
    return authRepository.resetPassword(params);
  }
}

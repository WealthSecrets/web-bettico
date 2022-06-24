import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/domain/repositories/auth_repository.dart';
import 'package:betticos/features/auth/domain/requests/forgot_request/forgot_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class ForgotPassword implements UseCase<User, ForgotRequest> {
  ForgotPassword({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(ForgotRequest params) {
    return authRepository.forgotPassword(params);
  }
}

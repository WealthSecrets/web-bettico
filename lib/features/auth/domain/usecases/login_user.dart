import 'package:betticos/features/auth/data/models/responses/auth_response/auth_response.dart';
import 'package:betticos/features/auth/domain/repositories/auth_repository.dart';
import 'package:betticos/features/auth/domain/requests/login_request/login_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class LoginUser implements UseCase<AuthResponse, LoginRequest> {
  LoginUser({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, AuthResponse>> call(LoginRequest params) {
    return authRepository.login(params);
  }
}

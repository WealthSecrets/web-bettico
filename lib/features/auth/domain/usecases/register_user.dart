import 'package:betticos/features/auth/data/models/responses/auth_response/auth_response.dart';
import 'package:betticos/features/auth/domain/repositories/auth_repository.dart';
import 'package:betticos/features/auth/domain/requests/register_request/register_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class RegisterUser implements UseCase<AuthResponse, RegisterRequest> {
  RegisterUser({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, AuthResponse>> call(RegisterRequest params) {
    return authRepository.register(params);
  }
}

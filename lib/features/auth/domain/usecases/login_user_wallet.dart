import 'package:betticos/features/auth/data/models/responses/auth_response/auth_response.dart';
import 'package:betticos/features/auth/domain/repositories/auth_repository.dart';
import 'package:betticos/features/auth/domain/requests/login_wallet_request/login_wallet_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class LoginUserWallet implements UseCase<AuthResponse, LoginWalletRequest> {
  LoginUserWallet({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, AuthResponse>> call(LoginWalletRequest params) {
    return authRepository.loginWallet(params);
  }
}

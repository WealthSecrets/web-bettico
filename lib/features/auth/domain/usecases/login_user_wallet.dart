import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/domain/repositories/auth_repository.dart';
import 'package:betticos/features/auth/domain/requests/login_wallet_request/login_wallet_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class LoginUserWallet implements UseCase<User, LoginWalletRequest> {
  LoginUserWallet({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(LoginWalletRequest params) {
    return authRepository.loginWallet(params);
  }
}

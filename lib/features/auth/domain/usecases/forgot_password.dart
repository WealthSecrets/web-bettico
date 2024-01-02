import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class ForgotPassword implements UseCase<User, ForgotRequest> {
  ForgotPassword({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(ForgotRequest params) {
    return authRepository.forgotPassword(params);
  }
}

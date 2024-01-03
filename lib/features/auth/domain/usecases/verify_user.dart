import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class VerifyUser implements UseCase<User, VerifyUserRequest> {
  VerifyUser({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(VerifyUserRequest params) {
    return authRepository.verifyUser(params);
  }
}

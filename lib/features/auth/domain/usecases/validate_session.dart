import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class ValidateSession implements UseCase<User, NoParams> {
  ValidateSession({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return authRepository.validateSession();
  }
}

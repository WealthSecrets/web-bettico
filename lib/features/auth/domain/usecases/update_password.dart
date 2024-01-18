import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class UpdatePassword implements UseCase<User, UpdatePasswordRequest> {
  UpdatePassword({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(UpdatePasswordRequest params) {
    return authRepository.updateMyPassword(params);
  }
}

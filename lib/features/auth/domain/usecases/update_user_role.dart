import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class UpdateUserRole implements UseCase<User, UpdateUserRoleRequest> {
  UpdateUserRole({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(UpdateUserRoleRequest params) {
    return authRepository.updateUserRole(params.role);
  }
}

import 'package:betticos/features/auth/domain/requests/update_user_role/update_user_role_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class UpdateUserRole implements UseCase<User, UpdateUserRoleRequest> {
  UpdateUserRole({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(UpdateUserRoleRequest params) {
    return authRepository.updateUserRole(params.role);
  }
}

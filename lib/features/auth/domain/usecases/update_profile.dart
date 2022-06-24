import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/repositories/auth_repository.dart';
import '/features/betticos/domain/requests/update_request/update_request.dart';

class UpdateProfile implements UseCase<User, UpdateRequest> {
  UpdateProfile({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(UpdateRequest params) {
    return authRepository.updateProfile(params);
  }
}

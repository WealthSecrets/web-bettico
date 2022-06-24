import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/domain/repositories/auth_repository.dart';
import 'package:betticos/features/betticos/domain/requests/update_request/update_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class UpdateUser implements UseCase<User, UpdateRequest> {
  UpdateUser({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(UpdateRequest params) {
    return authRepository.updateProfile(params);
  }
}

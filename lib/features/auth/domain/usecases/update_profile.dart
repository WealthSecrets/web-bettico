import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class UpdateProfile implements UseCase<User, UpdateRequest> {
  UpdateProfile({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(UpdateRequest params) {
    return authRepository.updateProfile(params);
  }
}

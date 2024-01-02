import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class UpdateUser implements UseCase<User, UpdateRequest> {
  UpdateUser({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(UpdateRequest params) {
    return authRepository.updateProfile(params);
  }
}

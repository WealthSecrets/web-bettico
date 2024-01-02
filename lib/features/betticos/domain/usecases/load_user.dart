import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class LoadUser implements UseCase<User, NoParams> {
  LoadUser({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return authRepository.loadUser();
  }
}

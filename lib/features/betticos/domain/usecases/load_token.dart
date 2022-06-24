import 'package:betticos/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class LoadToken implements UseCase<String, NoParams> {
  LoadToken({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return authRepository.loadToken();
  }
}

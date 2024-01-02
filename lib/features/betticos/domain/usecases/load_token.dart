import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class LoadToken implements UseCase<String, NoParams> {
  LoadToken({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return authRepository.loadToken();
  }
}

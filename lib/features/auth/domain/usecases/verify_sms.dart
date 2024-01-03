import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class VerifySms implements UseCase<User, VerifySmsRequest> {
  VerifySms({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(VerifySmsRequest params) {
    return authRepository.verifySms(params);
  }
}

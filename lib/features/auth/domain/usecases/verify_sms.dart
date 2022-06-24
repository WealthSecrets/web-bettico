import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/domain/repositories/auth_repository.dart';
import '/features/auth/domain/requests/verify_sms/verify_sms_request.dart';

class VerifySms implements UseCase<User, VerifySmsRequest> {
  VerifySms({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(VerifySmsRequest params) {
    return authRepository.verifySms(params);
  }
}

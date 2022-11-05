import 'package:betticos/features/auth/domain/requests/identification/identification_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class UploadIdentifcation implements UseCase<User, IdentificationRequest> {
  UploadIdentifcation({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(IdentificationRequest params) {
    return authRepository.updateUserIdentification(
      request: params,
    );
  }
}

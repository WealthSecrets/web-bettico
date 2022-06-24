import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/repositories/auth_repository.dart';
import '/features/auth/domain/requests/upload_request.dart/upload_request.dart';

class UploadIdentifcation implements UseCase<User, UploadRequest> {
  UploadIdentifcation({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(UploadRequest params) {
    return authRepository.updateUserIdentification(
      file: params.file,
      onSendProgress: params.onSendProgress,
      request: params.request,
    );
  }
}

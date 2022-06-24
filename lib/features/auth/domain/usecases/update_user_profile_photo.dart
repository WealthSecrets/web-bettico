import 'package:betticos/features/auth/domain/requests/update_photo_request.dart/update_photo_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class UpdateUserProfilePhoto implements UseCase<User, UpdatePhotoRequest> {
  UpdateUserProfilePhoto({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(UpdatePhotoRequest params) {
    return authRepository.updateUserProfilePhoto(
      file: params.file,
      onSendProgress: params.onSendProgress,
    );
  }
}

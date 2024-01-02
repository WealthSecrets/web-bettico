import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class UpdateUserProfilePhoto implements UseCase<User, UpdatePhotoRequest> {
  UpdateUserProfilePhoto({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(UpdatePhotoRequest params) {
    return authRepository.updateUserProfilePhoto(file: params.file, onSendProgress: params.onSendProgress);
  }
}

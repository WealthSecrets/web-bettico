import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class UploadIdentifcation implements UseCase<User, IdentificationRequest> {
  UploadIdentifcation({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(IdentificationRequest params) {
    return authRepository.updateUserIdentification(request: params);
  }
}

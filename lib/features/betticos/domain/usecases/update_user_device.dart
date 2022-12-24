import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/domain/repositories/betticos_repository.dart';
import 'package:betticos/features/betticos/domain/requests/user/user_device_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class UpdateUserDevice implements UseCase<User, UserDeviceRequest> {
  UpdateUserDevice({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, User>> call(UserDeviceRequest params) {
    return betticosRepository.updateUserDevice(device: params.device);
  }
}

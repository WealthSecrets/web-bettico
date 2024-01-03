import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class UpdateUserDevice implements UseCase<User, UserDeviceRequest> {
  UpdateUserDevice({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, User>> call(UserDeviceRequest params) {
    return betticosRepository.updateUserDevice(device: params.device);
  }
}

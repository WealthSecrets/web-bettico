import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class CreateSubAccount implements UseCase<OkxAccount, CreateSubAccountRequest> {
  CreateSubAccount({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, OkxAccount>> call(CreateSubAccountRequest params) {
    return okxRepository.createSubAccount(subAccount: params.subAccount);
  }
}

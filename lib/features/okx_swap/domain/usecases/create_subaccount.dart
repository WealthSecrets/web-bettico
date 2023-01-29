import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:betticos/features/okx_swap/domain/requests/sub_account/create_subaccount_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class CreateSubAccount implements UseCase<OkxAccount, CreateSubAccountRequest> {
  CreateSubAccount({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, OkxAccount>> call(CreateSubAccountRequest params) {
    return okxRepository.createSubAccount(subAccount: params.subAccount);
  }
}

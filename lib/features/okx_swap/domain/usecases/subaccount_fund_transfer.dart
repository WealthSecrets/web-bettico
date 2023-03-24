import 'package:betticos/features/okx_swap/data/models/funds/subaccount_funds_request.dart';
import 'package:betticos/features/okx_swap/data/models/funds/subaccount_funds_response.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class SubAccountFundTransfer
    implements UseCase<SubAccountFundsResponse, SubAccountFundsRequest> {
  SubAccountFundTransfer({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, SubAccountFundsResponse>> call(
      SubAccountFundsRequest params) {
    return okxRepository.transferFundToSubAccount(
      amount: params.amount,
      currency: params.currency,
      from: params.from,
      to: params.to,
      subAccount: params.subAccount,
    );
  }
}

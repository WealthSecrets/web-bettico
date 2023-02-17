import 'package:betticos/features/okx_swap/data/models/withdrawal/withdrawal_request.dart';
import 'package:betticos/features/okx_swap/data/models/withdrawal/withdrawal_response.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class Withdraw implements UseCase<WithdrawalResponse, WithdrawalRequest> {
  Withdraw({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, WithdrawalResponse>> call(WithdrawalRequest params) {
    return okxRepository.withdraw(
      fee: params.fee,
      amount: params.amount,
      chain: params.chain,
      method: params.method,
      currency: params.currency,
      toAddress: params.toAddress,
    );
  }
}

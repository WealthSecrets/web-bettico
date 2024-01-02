import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

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

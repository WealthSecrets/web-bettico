import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class SubAccountFundTransfer implements UseCase<SubAccountFundsResponse, SubAccountFundsRequest> {
  SubAccountFundTransfer({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, SubAccountFundsResponse>> call(SubAccountFundsRequest params) {
    return okxRepository.transferFundToSubAccount(
      amount: params.amount,
      currency: params.currency,
      from: params.from,
      to: params.to,
      subAccount: params.subAccount,
    );
  }
}

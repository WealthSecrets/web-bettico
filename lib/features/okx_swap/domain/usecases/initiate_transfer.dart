import 'package:betticos/features/okx_swap/data/models/transfer/transfer.dart';
import 'package:betticos/features/okx_swap/domain/repositories/paystack_repository.dart';
import 'package:betticos/features/okx_swap/domain/requests/transfer/transfer_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class InitiateTransfer implements UseCase<Transfer, TransferRequest> {
  InitiateTransfer({required this.paystackRepository});
  final PaystackRepository paystackRepository;

  @override
  Future<Either<Failure, Transfer>> call(TransferRequest params) {
    return paystackRepository.initiateTransfer(
      accountNumber: params.accountNumber,
      amount: params.amount,
      recipientCode: params.recipientCode,
      source: params.source,
    );
  }
}

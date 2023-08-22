import 'package:betticos/features/okx_swap/data/models/transfer/transfer.dart';
import 'package:betticos/features/okx_swap/domain/repositories/paystack_repository.dart';
import 'package:betticos/features/okx_swap/domain/requests/transfer/finalize_transfer_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class FinalizeTransfer implements UseCase<Transfer, FinalizeTransferRequest> {
  FinalizeTransfer({required this.paystackRepository});
  final PaystackRepository paystackRepository;

  @override
  Future<Either<Failure, Transfer>> call(FinalizeTransferRequest params) {
    return paystackRepository.finalizeTransfer(otp: params.otp, transferCode: params.transferCode);
  }
}

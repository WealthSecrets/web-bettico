import 'package:betticos/features/okx_swap/data/models/recipient/recipient.dart';
import 'package:betticos/features/okx_swap/domain/repositories/paystack_repository.dart';
import 'package:betticos/features/okx_swap/domain/requests/recipient/recipient_request.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class CreateRecipient implements UseCase<Recipient, RecipientRequest> {
  CreateRecipient({required this.paystackRepository});
  final PaystackRepository paystackRepository;

  @override
  Future<Either<Failure, Recipient>> call(RecipientRequest params) {
    return paystackRepository.createRecipient(
      type: params.type,
      accountNumber: params.accountNumber,
      bankCode: params.bankCode,
      currency: params.currency,
      name: params.name,
      usdtAmount: params.usdAmount,
      amount: params.amount,
      destination: params.destination,
    );
  }
}

import 'package:betticos/features/okx_swap/data/models/bank/bank.dart';
import 'package:betticos/features/okx_swap/domain/repositories/paystack_repository.dart';
import 'package:betticos/features/okx_swap/domain/requests/bank/bank_request.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class FetchBanksTelcos implements UseCase<List<Bank>, BankRequest> {
  FetchBanksTelcos({required this.paystackRepository});
  final PaystackRepository paystackRepository;

  @override
  Future<Either<Failure, List<Bank>>> call(BankRequest params) {
    return paystackRepository.fetchBankOrTelcos(currency: params.currency, type: params.type);
  }
}

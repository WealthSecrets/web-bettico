import 'package:betticos/features/okx_swap/data/models/bank/resolve_response.dart';
import 'package:betticos/features/okx_swap/domain/repositories/paystack_repository.dart';
import 'package:betticos/features/okx_swap/domain/requests/resolve_account/resolve_account_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class ResolveAccount implements UseCase<ResolveResponse, ResolveAccountRequest> {
  ResolveAccount({required this.paystackRepository});
  final PaystackRepository paystackRepository;

  @override
  Future<Either<Failure, ResolveResponse>> call(ResolveAccountRequest params) {
    return paystackRepository.resolveAccount(accoutNumber: params.accoutNumber, bankCode: params.bankCode);
  }
}

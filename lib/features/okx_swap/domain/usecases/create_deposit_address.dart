import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_response.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class CreateDepositAddress
    implements
        UseCase<CreateDepositAddressResponse, CreateDepositAddressRequest> {
  CreateDepositAddress({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, CreateDepositAddressResponse>> call(
      CreateDepositAddressRequest params) {
    return okxRepository.createDepositAddress(
      currency: params.currency,
      chain: params.chain,
    );
  }
}

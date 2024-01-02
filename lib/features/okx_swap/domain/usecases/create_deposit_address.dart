import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class CreateDepositAddress implements UseCase<CreateDepositAddressResponse, CreateDepositAddressRequest> {
  CreateDepositAddress({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, CreateDepositAddressResponse>> call(CreateDepositAddressRequest params) {
    return okxRepository.createDepositAddress(currency: params.currency, chain: params.chain);
  }
}

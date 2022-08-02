import 'package:betticos/features/p2p_betting/data/models/crypto/volume.dart';
import 'package:betticos/features/p2p_betting/domain/requests/crypto/convert_amount_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class ConvertAmountToCurrency implements UseCase<Volume, ConvertAmountRequest> {
  ConvertAmountToCurrency({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, Volume>> call(ConvertAmountRequest params) {
    return p2pRepository.convertAmount(
      params.currency,
      params.amount,
    );
  }
}

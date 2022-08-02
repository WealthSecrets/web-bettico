import 'package:betticos/features/p2p_betting/data/models/crypto/network.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class FetchCryptNetworks implements UseCase<List<Network>, NoParams> {
  FetchCryptNetworks({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, List<Network>>> call(NoParams params) {
    return p2pRepository.fetchCryptoNetworks();
  }
}

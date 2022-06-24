import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/bet/bet.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class FetchAwaitingBets implements UseCase<List<Bet>, NoParams> {
  FetchAwaitingBets({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, List<Bet>>> call(NoParams params) {
    return p2pRepository.fetchAwaitingBets();
  }
}

import 'package:betticos/features/p2p_betting/domain/requests/bet/status_bets_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/bet/bet.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class FetchStatusBets implements UseCase<List<Bet>, StatusBetsRequests> {
  FetchStatusBets({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, List<Bet>>> call(StatusBetsRequests params) {
    return p2pRepository.fetchStatusBets(params.status);
  }
}

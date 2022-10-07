import 'package:betticos/features/p2p_betting/domain/requests/bet/update_bet_status_score_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/bet/bet.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class UpdateBetStatusScore implements UseCase<Bet, UpdateBetStatusScoreRequest> {
  UpdateBetStatusScore({required this.p2prepository});
  final P2pRepository p2prepository;

  @override
  Future<Either<Failure, Bet>> call(UpdateBetStatusScoreRequest params) {
    return p2prepository.updateBetStatusScore(
      betId: params.betId,
      score: params.score,
      status: params.status,
    );
  }
}

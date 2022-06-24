import 'package:betticos/features/p2p_betting/domain/requests/bet/update_bet_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/bet/bet.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class UpdateBet implements UseCase<Bet, UpdateBetRequest> {
  UpdateBet({required this.p2prepository});
  final P2pRepository p2prepository;

  @override
  Future<Either<Failure, Bet>> call(UpdateBetRequest params) {
    return p2prepository.updateBet(
      betId: params.betId,
      opponent: params.opponent,
      status: params.status,
    );
  }
}

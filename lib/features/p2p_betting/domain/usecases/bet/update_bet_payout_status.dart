import 'package:betticos/features/p2p_betting/domain/requests/bet/update_bet_payout_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/bet/bet.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class UpdateBetPayoutStatus implements UseCase<Bet, UpdateBetPayoutRequest> {
  UpdateBetPayoutStatus({required this.p2prepository});
  final P2pRepository p2prepository;

  @override
  Future<Either<Failure, Bet>> call(UpdateBetPayoutRequest params) {
    return p2prepository.updateBetPayoutStatus(
      betId: params.betId,
      payout: params.payout,
      status: params.status,
      txthash: params.txthash,
    );
  }
}

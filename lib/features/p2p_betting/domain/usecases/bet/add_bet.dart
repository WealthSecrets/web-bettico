import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/bet/bet.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';
import '../../requests/bet/bet_request.dart';

class AddBet implements UseCase<Bet, BetRequest> {
  AddBet({required this.p2prepository});
  final P2pRepository p2prepository;

  @override
  Future<Either<Failure, Bet>> call(BetRequest params) {
    return p2prepository.addBet(
      txthash: params.txthash,
      amount: params.amount,
      competitionId: params.competitionId,
      creator: params.creator,
      opponent: params.opponent,
      status: params.status,
      date: params.date,
      isFixture: params.isFixture,
      score: params.score,
      time: params.time,
      homeTeam: params.homeTeam,
      awayTeam: params.awayTeam,
    );
  }
}

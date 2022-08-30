import 'package:betticos/features/p2p_betting/data/models/sportmonks/sleague/sleague.dart';
import 'package:betticos/features/p2p_betting/domain/repositories/p2p_repository.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/s_league_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class GetLeague implements UseCase<SLeague, SLeagueRequest> {
  GetLeague({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, SLeague>> call(SLeagueRequest params) {
    return p2pRepository.getLeague(params.leagueId);
  }
}

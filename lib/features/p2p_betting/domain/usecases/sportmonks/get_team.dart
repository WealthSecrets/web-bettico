import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/domain/repositories/p2p_repository.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/team_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class GetTeam implements UseCase<Team, TeamRequest> {
  GetTeam({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, Team>> call(TeamRequest params) {
    return p2pRepository.getTeam(params.teamId);
  }
}

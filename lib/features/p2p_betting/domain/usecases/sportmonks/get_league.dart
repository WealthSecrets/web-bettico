import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
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

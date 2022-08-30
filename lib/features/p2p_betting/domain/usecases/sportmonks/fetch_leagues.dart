import 'package:betticos/features/p2p_betting/data/models/sportmonks/sleague/sleague.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class FetchLeagues implements UseCase<List<SLeague>, NoParams> {
  FetchLeagues({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, List<SLeague>>> call(NoParams params) {
    return p2pRepository.fetchLeagues();
  }
}

import 'package:betticos/features/p2p_betting/domain/requests/bet/search_bet_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/bet/bet.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class SearchBets implements UseCase<List<Bet>, SearchBetRequest> {
  SearchBets({required this.p2pRepository});
  final P2pRepository p2pRepository;

  @override
  Future<Either<Failure, List<Bet>>> call(SearchBetRequest params) {
    return p2pRepository.getFilteredBets(
      status: params.status,
      title: params.title,
      from: params.from,
      to: params.to,
    );
  }
}

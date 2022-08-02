import 'package:betticos/features/p2p_betting/data/models/bet/bet.dart';
import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/bet_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/bet_update_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/team_request.dart';
import 'package:dartz/dartz.dart';

import '../models/crypto/network.dart';
import '../models/crypto/volume.dart';
import '/core/core.dart';
import '/features/p2p_betting/data/data_sources/p2p_remote_data_source.dart';
import '/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import '../../domain/repositories/p2p_repository.dart';
import '../../domain/requests/bet/bettor_request.dart';

class P2pRepositoryImpl extends Repository implements P2pRepository {
  P2pRepositoryImpl({
    required this.p2pRemoteDataSource,
  });

  final P2pRemoteDataSource p2pRemoteDataSource;

  @override
  Future<Either<Failure, List<SoccerMatch>>> getLiveMatches(
    String apiKey,
    String secretKey,
  ) =>
      makeRequest(
        p2pRemoteDataSource.getLiveMatches(apiKey, secretKey),
      );

  @override
  Future<Either<Failure, List<Fixture>>> getFixtures(
    String apiKey,
    String secretKey,
  ) =>
      makeRequest(
        p2pRemoteDataSource.getFixtures(apiKey, secretKey),
      );

  @override
  Future<Either<Failure, SoccerMatch?>> getCompetitionMatch(
    String apiKey,
    String secretKey,
    int competitionId,
    int teamId,
  ) =>
      makeRequest(
        p2pRemoteDataSource.getCompetitionMatch(
          apiKey,
          secretKey,
          competitionId,
          teamId,
        ),
      );

  @override
  Future<Either<Failure, SoccerMatch?>> getFixture(
    String apiKey,
    String secretKey,
    int competitionId,
    int teamId,
    String date,
  ) =>
      makeRequest(
        p2pRemoteDataSource.getFixture(
          apiKey,
          secretKey,
          competitionId,
          teamId,
          date,
        ),
      );

  @override
  Future<Either<Failure, SoccerMatch?>> getTeamMatch(
    String apiKey,
    String secretKey,
    int teamId,
    int competitionId,
    String date,
  ) =>
      makeRequest(
        p2pRemoteDataSource.getTeamMatch(
          apiKey,
          secretKey,
          teamId,
          competitionId,
          date,
        ),
      );

  @override
  Future<Either<Failure, Bet>> addBet({
    required double amount,
    required int competitionId,
    String? status,
    required BettorRequest creator,
    BettorRequest? opponent,
    required TeamRequest awayTeam,
    required TeamRequest homeTeam,
    String? date,
    String? time,
    String? score,
    bool? isFixture,
  }) =>
      makeRequest(
        p2pRemoteDataSource.addBet(
          request: BetRequest(
            amount: amount,
            competitionId: competitionId,
            creator: creator,
            opponent: opponent,
            awayTeam: awayTeam,
            homeTeam: homeTeam,
            isFixture: isFixture,
            score: score,
            date: date,
            time: time,
          ),
        ),
      );

  @override
  Future<Either<Failure, Bet>> updateBet({
    required String betId,
    required String status,
    required BettorRequest opponent,
  }) =>
      makeRequest(
        p2pRemoteDataSource.updateBet(
          request: BetUpdateRequest(opponent: opponent, status: status),
          betId: betId,
        ),
      );

  @override
  Future<Either<Failure, List<Bet>>> fetchBets() => makeRequest(
        p2pRemoteDataSource.fetchBets(),
      );

  @override
  Future<Either<Failure, List<Bet>>> fetchAwaitingBets() => makeRequest(
        p2pRemoteDataSource.fetchAwaitingBets(),
      );

  @override
  Future<Either<Failure, List<Bet>>> fetchMyBets() => makeRequest(
        p2pRemoteDataSource.fetchMyBets(),
      );

  @override
  Future<Either<Failure, List<Network>>> fetchCryptoNetworks() =>
      makeRequest(p2pRemoteDataSource.fetchCryptoNetworks());

  @override
  Future<Either<Failure, Volume>> convertAmount(String symbol, double amount) =>
      makeRequest(p2pRemoteDataSource.convertAmount(symbol, amount));
}

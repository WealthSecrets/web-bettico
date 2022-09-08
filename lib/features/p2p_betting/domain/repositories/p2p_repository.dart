import 'package:betticos/features/p2p_betting/data/models/bet/bet.dart';
import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/sleague/sleague.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/bettor_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/team_request.dart';
import 'package:dartz/dartz.dart';

import '/core/errors/failure.dart';
import '../../../betticos/data/models/listpage/listpage.dart';
import '../../data/models/crypto/network.dart';
import '../../data/models/crypto/volume.dart';

abstract class P2pRepository {
  Future<Either<Failure, List<SoccerMatch>>> getLiveMatches(
    String apiKey,
    String secretKey,
  );

  Future<Either<Failure, List<Fixture>>> getFixtures(
    String apiKey,
    String secretKey,
  );

  Future<Either<Failure, ListPage<LiveScore>>> fetchPaginatedLiveScores(
    int page,
    int limit,
    int leagueId,
  );

  Future<Either<Failure, List<LiveScore>>> fetchLiveScores(int leagueId);

  Future<Either<Failure, List<LiveScore>>> fetchFixtures(int leagueId);

  Future<Either<Failure, ListPage<LiveScore>>> fetchPaginatedFixtures(
    int page,
    int limit,
    int leagueId,
  );

  Future<Either<Failure, List<Network>>> fetchCryptoNetworks();

  Future<Either<Failure, Volume>> convertAmount(String symbol, double amount);

  Future<Either<Failure, SoccerMatch?>> getCompetitionMatch(
    String apiKey,
    String secretKey,
    int competitionId,
    int teamId,
  );

  Future<Either<Failure, SoccerMatch?>> getFixture(
    String apiKey,
    String secretKey,
    int competitionId,
    int teamId,
    String date,
  );

  Future<Either<Failure, Team>> getTeam(int teamId);

  Future<Either<Failure, SLeague>> getLeague(int leagueId);

  Future<Either<Failure, LiveScore>> getSFixture(int fixtureId);

  Future<Either<Failure, SoccerMatch?>> getTeamMatch(
    String apiKey,
    String secretKey,
    int teamId,
    int competitionId,
    String date,
  );

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
  });

  Future<Either<Failure, Bet>> updateBet({
    required String betId,
    required String status,
    required BettorRequest opponent,
  });

  Future<Either<Failure, List<Bet>>> fetchBets();

  Future<Either<Failure, List<SLeague>>> fetchLeagues();

  Future<Either<Failure, List<Bet>>> fetchAwaitingBets();

  Future<Either<Failure, List<Bet>>> fetchMyBets();
}
